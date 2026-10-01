local QBCore = exports['qb-core']:GetCoreObject()

local function isCompleted(value)
    return value == true
        or value == 1
        or value == '1'
        or value == 'true'
end

local function getJsonPath()
    local key = tostring(Config.OnboardingMetadataKey or 'faux_onboarding_complete'):gsub('"', '')
    return '$."' .. key .. '"'
end

local function sqlString(value)
    return "'" .. tostring(value):gsub("'", "''") .. "'"
end

local function normalizeAffectedRows(result)
    if type(result) == 'number' then
        return result
    end

    if type(result) == 'table' then
        if result.affectedRows then
            return result.affectedRows
        end

        if result[1] and result[1].affectedRows then
            return result[1].affectedRows
        end
    end

    return 0
end

local function executeSql(sql, params)
    if MySQL and MySQL.update and MySQL.update.await then
        if params then
            return MySQL.update.await(sql, params)
        end

        return MySQL.update.await(sql)
    end

    if MySQL and MySQL.query and MySQL.query.await then
        if params then
            return MySQL.query.await(sql, params)
        end

        return MySQL.query.await(sql)
    end

    return nil
end

local function getDbCompleted(citizenid)
    if not citizenid then
        return false
    end

    if not MySQL or not MySQL.query or not MySQL.query.await then
        return false
    end

    local pathLiteral = sqlString(getJsonPath())

    local query = ([[
        SELECT JSON_UNQUOTE(JSON_EXTRACT(metadata, %s)) AS onboarding_complete
        FROM players
        WHERE citizenid = ?
        LIMIT 1
    ]]):format(pathLiteral)

    local result = MySQL.query.await(query, { citizenid })

    return isCompleted(result and result[1] and result[1].onboarding_complete)
end

local function setOnlinePlayerCompleted(player, reason)
    if not player then
        return false
    end

    player.Functions.SetMetaData(Config.OnboardingMetadataKey, true)

    print(('[faux-onboard] Marked citizenid %s as completed (%s).'):format(
        player.PlayerData.citizenid or 'Unknown',
        reason or 'manual'
    ))

    return true
end

RegisterNetEvent('faux-onboard:server:completeOnboarding', function()
    local source = source
    local player = QBCore.Functions.GetPlayer(source)

    if not player then
        return
    end

    player.Functions.SetMetaData(Config.OnboardingMetadataKey, true)
end)

RegisterNetEvent('faux-onboard:server:requestOpeningPage', function(isAutoOpen)
    local source = source
    local player = QBCore.Functions.GetPlayer(source)

    if not player then
        return
    end

    local completed = isCompleted(player.PlayerData.metadata[Config.OnboardingMetadataKey])

    if not completed then
        completed = getDbCompleted(player.PlayerData.citizenid)
    end

    -- If this is an automatic attempt, such as closing the clothing/skin menu,
    -- do not reopen the menu for players who already completed onboarding.
    if isAutoOpen and completed then
        return
    end

    TriggerClientEvent('faux-onboard:client:open', source, completed and 'chapters' or 'guide')
end)

-- Run once from the SERVER console:
-- fauxonboard-migrate-legacy
RegisterCommand(Config.LegacyMigrationCommand, function(source)
    if tonumber(source) ~= 0 then
        print(('[faux-onboard] "%s" can only be run from the server console.'):format(Config.LegacyMigrationCommand))
        return
    end

    if not MySQL then
        print('[faux-onboard] A MySQL resource is required to run the legacy onboarding migration.')
        return
    end

    local pathLiteral = sqlString(getJsonPath())

    -- Mark every existing character as completed unless they are already marked true.
    -- This also updates characters whose value is false, "false", null, missing, etc.
    local sql = ([[
        UPDATE players
        SET metadata = CASE
            WHEN JSON_VALID(metadata) AND JSON_TYPE(metadata) = 'OBJECT' THEN
                JSON_SET(metadata, %s, true)

            WHEN metadata IS NULL OR metadata = '' OR (JSON_VALID(metadata) AND JSON_TYPE(metadata) = 'NULL') THEN
                JSON_SET(JSON_OBJECT(), %s, true)

            ELSE metadata
        END
        WHERE
            (
                JSON_VALID(metadata)
                AND JSON_TYPE(metadata) = 'OBJECT'
                AND COALESCE(JSON_UNQUOTE(JSON_EXTRACT(metadata, %s)), 'false') <> 'true'
            )
            OR metadata IS NULL
            OR metadata = ''
            OR (JSON_VALID(metadata) AND JSON_TYPE(metadata) = 'NULL')
    ]]):format(pathLiteral, pathLiteral, pathLiteral)

    local result = executeSql(sql)
    local updated = normalizeAffectedRows(result)

    -- Sync online players whose DB row is completed but whose in-memory metadata is not.
    -- This prevents QBCore from overwriting the DB value later with the old cached metadata.
    local onlineSynced = 0

    for _, playerId in ipairs(GetPlayers()) do
        local playerSrc = tonumber(playerId)
        local player = QBCore.Functions.GetPlayer(playerSrc)

        if player then
            local memoryCompleted = isCompleted(player.PlayerData.metadata[Config.OnboardingMetadataKey])

            if not memoryCompleted and getDbCompleted(player.PlayerData.citizenid) then
                player.Functions.SetMetaData(Config.OnboardingMetadataKey, true)
                onlineSynced = onlineSynced + 1
            end
        end
    end

    print(('[faux-onboard] Legacy migration complete. DB rows updated: %s | online players synced: %s'):format(
        updated,
        onlineSynced
    ))
end, true)

-- Server console command:
-- fauxonboard-force-complete <serverId or citizenid>
RegisterCommand('fauxonboard-force-complete', function(source, args)
    if tonumber(source) ~= 0 then
        print('[faux-onboard] fauxonboard-force-complete can only be run from the server console.')
        return
    end

    local target = args[1]

    if not target or target == '' then
        print('[faux-onboard] Usage: fauxonboard-force-complete <serverId or citizenid>')
        return
    end

    -- Try by server ID first.
    local src = tonumber(target)

    if src then
        local player = QBCore.Functions.GetPlayer(src)

        if player then
            setOnlinePlayerCompleted(player, 'force-complete by server ID')
            return
        end
    end

    -- Try by citizenid for an online player.
    for _, playerId in ipairs(GetPlayers()) do
        local playerSrc = tonumber(playerId)
        local player = QBCore.Functions.GetPlayer(playerSrc)

        if player and player.PlayerData.citizenid == target then
            setOnlinePlayerCompleted(player, 'force-complete by citizenid')
            return
        end
    end

    -- Fallback: offline database update.
    local pathLiteral = sqlString(getJsonPath())

    local sql = ([[
        UPDATE players
        SET metadata = CASE
            WHEN JSON_VALID(metadata) AND JSON_TYPE(metadata) = 'OBJECT' THEN
                JSON_SET(metadata, %s, true)

            WHEN metadata IS NULL OR metadata = '' OR (JSON_VALID(metadata) AND JSON_TYPE(metadata) = 'NULL') THEN
                JSON_SET(JSON_OBJECT(), %s, true)

            ELSE metadata
        END
        WHERE citizenid = ?
    ]]):format(pathLiteral, pathLiteral)

    local result = executeSql(sql, { target })
    local updated = normalizeAffectedRows(result)

    print(('[faux-onboard] Offline force-complete finished for %s. Rows updated: %s'):format(target, updated))
end, true)
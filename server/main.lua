local QBCore = exports['qb-core']:GetCoreObject()

local function isCompleted(value)
    return value == true or value == 1 or value == '1' or value == 'true'
end

RegisterNetEvent('faux-onboard:server:completeOnboarding', function()
    local player = QBCore.Functions.GetPlayer(source)
    if not player then
        return
    end

    player.Functions.SetMetaData(Config.OnboardingMetadataKey, true)
end)

RegisterNetEvent('faux-onboard:server:requestOpeningPage', function()
    local source = source
    local player = QBCore.Functions.GetPlayer(source)
    if not player then
        return
    end

    local completed = isCompleted(player.PlayerData.metadata[Config.OnboardingMetadataKey])

    -- Query the saved value too, so a legacy migration takes effect without waiting
    -- for an in-memory player object to be recreated.
    if not completed and MySQL and MySQL.query and MySQL.query.await then
        local metadataKey = Config.OnboardingMetadataKey:gsub('[^%w_]', '')
        local result = MySQL.query.await(
            'SELECT JSON_UNQUOTE(JSON_EXTRACT(metadata, ?)) AS onboarding_complete FROM players WHERE citizenid = ? LIMIT 1',
            { '$."' .. metadataKey .. '"', player.PlayerData.citizenid }
        )
        completed = isCompleted(result and result[1] and result[1].onboarding_complete)
    end

    TriggerClientEvent('faux-onboard:client:open', source, completed and 'chapters' or 'guide')
end)

-- Run this once from the server console after installing the Chapters update.
-- It marks only pre-existing QBCore characters that do not yet have this resource's metadata key.
RegisterCommand(Config.LegacyMigrationCommand, function(source)
    if tonumber(source) ~= 0 then
        print(('[faux-onboard] "%s" can only be run from the server console.'):format(Config.LegacyMigrationCommand))
        return
    end

    if not MySQL or not MySQL.query or not MySQL.query.await then
        print('[faux-onboard] oxmysql is required to run the legacy onboarding migration.')
        return
    end

    local metadataKey = Config.OnboardingMetadataKey:gsub('[^%w_]', '')
    local jsonPath = '$."' .. metadataKey .. '"'
    local query = ([[
        UPDATE players
        SET metadata = JSON_SET(
            CASE WHEN JSON_VALID(metadata) THEN metadata ELSE JSON_OBJECT() END,
            '%s',
            true
        )
        WHERE JSON_EXTRACT(
            CASE WHEN JSON_VALID(metadata) THEN metadata ELSE JSON_OBJECT() END,
            '%s'
        ) IS NULL
    ]]):format(jsonPath, jsonPath)

    local updated = MySQL.query.await(query)
    print(('[faux-onboard] Legacy migration complete. Marked %s existing character(s) for Chapters.'):format(updated or 0))
end, true)

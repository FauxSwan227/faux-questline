local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('faux-onboard:server:completeOnboarding', function()
    local player = QBCore.Functions.GetPlayer(source)
    if not player then
        return
    end

    player.Functions.SetMetaData(Config.OnboardingMetadataKey, true)
end)

-- Run this once from the server console after installing the Chapters update.
-- It marks only pre-existing QBCore characters that do not yet have this resource's metadata key.
RegisterCommand(Config.LegacyMigrationCommand, function(source)
    if tonumber(source) ~= 0 then
        print(('[faux-onboard] "%s" can only be run from the server console.'):format(Config.LegacyMigrationCommand))
        return
    end

    if not MySQL or not MySQL.update or not MySQL.update.await then
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

    local updated = MySQL.update.await(query)
    print(('[faux-onboard] Legacy migration complete. Marked %s existing character(s) for Chapters.'):format(updated or 0))
end, true)

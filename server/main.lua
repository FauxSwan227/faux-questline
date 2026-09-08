local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('faux-onboard:server:completeOnboarding', function()
    local player = QBCore.Functions.GetPlayer(source)
    if not player then
        return
    end

    player.Functions.SetMetaData(Config.OnboardingMetadataKey, true)
end)

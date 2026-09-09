local QBCore = exports['qb-core']:GetCoreObject()
local nuiOpen = false

local function notify(message, messageType)
    TriggerEvent('QBCore:Notify', message, messageType or 'primary')
end

local function pageById(pageId)
    for _, page in ipairs(Config.Pages) do
        if page.id == pageId then
            return page
        end
    end

    return nil
end

local function hasCompletedOnboarding()
    local playerData = QBCore.Functions.GetPlayerData()
    local metadata = playerData and playerData.metadata or {}

    local completed = metadata[Config.OnboardingMetadataKey]

    return completed == true or completed == 1 or completed == 'true'
end

local function buildPayload()
    return {
        brand = Config.Brand,
        pages = Config.Pages,
        keybindPages = Config.KeybindPages,
        commandPages = Config.CommandPages,
        faqs = Config.FAQs,
        chapters = Config.Chapters,
        initialTab = hasCompletedOnboarding() and 'chapters' or 'guide'
    }
end

local function setFocus(state)
    nuiOpen = state
    SetNuiFocus(state, state)
end

local function openOnboarding()
    SendNUIMessage({
        action = 'open',
        payload = buildPayload()
    })
    setFocus(true)
end

local function closeOnboarding()
    SendNUIMessage({ action = 'close' })
    setFocus(false)
end

RegisterNetEvent('faux-onboard:client:open', function()
    openOnboarding()
end)

RegisterNetEvent('faux-onboard:client:close', function()
    closeOnboarding()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    if Config.AutoOpenOnPlayerLoaded then
        openOnboarding()
    end
end)

RegisterNetEvent('faux-onboard:client:startIntro', function()
    openOnboarding()
end)

RegisterNUICallback('close', function(_, cb)
    closeOnboarding()
    cb({ ok = true })
end)

RegisterNUICallback('setWaypoint', function(data, cb)
    local page = pageById(data and data.pageId)

    if not page or not page.waypoint then
        notify('No waypoint is available for this page.', 'error')
        cb({ ok = false })
        return
    end

    closeOnboarding()
    SetNewWaypoint(page.waypoint.x, page.waypoint.y)
    notify(('Waypoint set: %s'):format(page.mapLabel or page.title), 'success')
    cb({ ok = true })
end)

RegisterNUICallback('complete', function(_, cb)
    closeOnboarding()
    notify('Welcome to the city. Your journey begins now.', 'success')

    TriggerServerEvent('faux-onboard:server:completeOnboarding')

    if Config.CompleteEvent then
        TriggerServerEvent(Config.CompleteEvent)
    end

    cb({ ok = true })
end)

RegisterNUICallback('runCommand', function(data, cb)
    local command = data and data.command

    if type(command) ~= 'string' or command == '' or command:find('%s') or command:find('^/') then
        cb({ ok = false })
        return
    end

    ExecuteCommand(command)
    cb({ ok = true })
end)

if Config.DebugCommand then
    RegisterCommand('onboard', function()
        openOnboarding()
    end, false)

    RegisterCommand('fauxonboard', function()
        openOnboarding()
    end, false)
end

RegisterKeyMapping('onboard', 'Open Onboarding UI', 'keyboard', Config.OpenKey)

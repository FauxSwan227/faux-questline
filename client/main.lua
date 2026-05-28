local QBCore = exports['qb-core']:GetCoreObject()
local nuiOpen = false
local activeQuestHud = false
local currentQuestHud = nil
local pauseMenuHidingHud = false

local function sendQuestHud(visible, quest)
    SendNUIMessage({
        action = 'questHud',
        payload = {
            visible = visible,
            title = quest and quest.title,
            objective = quest and (quest.objective or quest.description),
            cancelText = quest and (('Press %s to cancel quest'):format(Config.CancelKey or 'X'))
        }
    })
end

local function setFocus(state)
    nuiOpen = state
    SetNuiFocus(state, state)
end

local function openQuestUi(payload)
    SendNUIMessage({
        action = 'open',
        payload = payload
    })
    setFocus(true)
end

local function closeQuestUi()
    SendNUIMessage({ action = 'close' })
    setFocus(false)

    if activeQuestHud and currentQuestHud and not IsPauseMenuActive() then
        sendQuestHud(true, currentQuestHud)
    end
end

RegisterNetEvent('faux-questline:client:open', function(payload)
    openQuestUi(payload)
end)

RegisterNetEvent('faux-questline:client:close', function()
    closeQuestUi()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    if Config.AutoOpenOnPlayerLoaded then
        TriggerServerEvent('faux-questline:server:requestUiData')
    end
end)

RegisterNetEvent('faux-questline:client:tryStartIntro', function()
    TriggerServerEvent('faux-questline:server:requestUiData')
end)

RegisterNUICallback('close', function(_, cb)
    closeQuestUi()
    cb({ ok = true })
end)

RegisterNUICallback('getStarted', function(_, cb)
    TriggerServerEvent('faux-questline:server:startIntroQuest')
    cb({ ok = true })
end)

RegisterNUICallback('startQuest', function(data, cb)
    TriggerServerEvent('faux-questline:server:startQuest', data.category, data.questId)
    cb({ ok = true })
end)

RegisterNUICallback('claimReward', function(data, cb)
    TriggerServerEvent('faux-questline:server:claimQuestReward', data.category, data.questId)
    cb({ ok = true })
end)

RegisterNetEvent('faux-questline:client:showQuestHud', function(quest)
    activeQuestHud = true
    currentQuestHud = quest

    if not IsPauseMenuActive() and not nuiOpen then
        sendQuestHud(true, currentQuestHud)
    end
end)

RegisterNetEvent('faux-questline:client:hideQuestHud', function()
    activeQuestHud = false
    currentQuestHud = nil
    pauseMenuHidingHud = false
    sendQuestHud(false)
end)

RegisterNetEvent('faux-questline:client:questItemResult', function(item, hasItem)
    SendNUIMessage({
        action = 'questItemResult',
        payload = {
            item = item,
            hasItem = hasItem
        }
    })
end)

if Config.DebugCommand then
    RegisterCommand('questui', function()
        TriggerServerEvent('faux-questline:server:requestUiData')
    end, false)

    RegisterCommand('questhud', function()
        TriggerEvent('faux-questline:client:showQuestHud', {
            title = 'The Honest Worker',
            objective = 'Complete 5 delivery shifts for Post-OP'
        })
    end, false)
end

RegisterKeyMapping('questui', 'Open Questline UI', 'keyboard', Config.OpenKey)

CreateThread(function()
    while true do
        if activeQuestHud and not nuiOpen then
            Wait(0)

            if IsControlJustPressed(0, 73) then
                TriggerServerEvent('faux-questline:server:cancelQuest')
            end
        else
            Wait(350)
        end
    end
end)

CreateThread(function()
    while true do
        if activeQuestHud then
            local pauseActive = IsPauseMenuActive()

            if pauseActive and not pauseMenuHidingHud then
                pauseMenuHidingHud = true
                sendQuestHud(false)
            elseif not pauseActive and pauseMenuHidingHud then
                pauseMenuHidingHud = false

                if not nuiOpen and currentQuestHud then
                    sendQuestHud(true, currentQuestHud)
                end
            end

            Wait(250)
        else
            Wait(750)
        end
    end
end)

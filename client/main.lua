local QBCore = exports['qb-core']:GetCoreObject()
local nuiOpen = false

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
    SendNUIMessage({
        action = 'questHud',
        payload = {
            visible = true,
            title = quest.title,
            objective = quest.objective or quest.description,
            cancelText = ('Press %s to cancel quest'):format(Config.CancelKey or 'X')
        }
    })
end)

RegisterNetEvent('faux-questline:client:hideQuestHud', function()
    SendNUIMessage({
        action = 'questHud',
        payload = { visible = false }
    })
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

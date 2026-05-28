local QBCore = exports['qb-core']:GetCoreObject()

local function notify(source, message, messageType)
    TriggerClientEvent('QBCore:Notify', source, message, messageType or 'primary')
end

local function findQuest(category, questId)
    local quests = Config.Quests[category]
    if not quests then return nil end

    for _, quest in ipairs(quests) do
        if quest.id == questId then
            return quest
        end
    end

    return nil
end

local function getCharacterName(Player)
    if not Player or not Player.PlayerData then
        return Config.Profile.fallbackName
    end

    local charinfo = Player.PlayerData.charinfo or {}
    local first = charinfo.firstname or ''
    local last = charinfo.lastname or ''
    local full = (first .. ' ' .. last):gsub('^%s+', ''):gsub('%s+$', '')

    if full == '' then
        return Player.PlayerData.name or Config.Profile.fallbackName
    end

    return full
end

local function getTotals()
    local total = 0
    local completed = 0

    for _, quests in pairs(Config.Quests) do
        for _, quest in ipairs(quests) do
            total = total + 1
            if quest.status == 'completed' then
                completed = completed + 1
            end
        end
    end

    return completed, total
end

local function buildPayload(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local completed, total = getTotals()

    return {
        brand = Config.Brand,
        profile = {
            name = getCharacterName(Player),
            avatarUrl = Config.Profile.getAvatarUrl(source)
        },
        totals = {
            completed = completed,
            total = total
        },
        categories = Config.Categories,
        quests = Config.Quests
    }
end

RegisterNetEvent('faux-questline:server:requestUiData', function()
    local src = source
    TriggerClientEvent('faux-questline:client:open', src, buildPayload(src))
end)

RegisterNetEvent('faux-questline:server:startIntroQuest', function()
    local src = source
    TriggerClientEvent('faux-questline:client:showQuestHud', src, {
        title = 'Fresh Off The Boat',
        objective = 'Visit City Hall and collect your legal documents'
    })
end)

RegisterNetEvent('faux-questline:server:startQuest', function(category, questId)
    local src = source
    local quest = findQuest(category, questId)
    if not quest then return end

    if quest.status == 'locked' then
        notify(src, 'This quest is locked.', 'error')
        return
    end

    if quest.status == 'completed' then
        notify(src, 'You have already completed this quest.', 'error')
        return
    end

    TriggerClientEvent('faux-questline:client:showQuestHud', src, {
        title = quest.title,
        objective = quest.description
    })
end)

RegisterNetEvent('faux-questline:server:claimQuestReward', function(category, questId)
    local src = source
    local quest = findQuest(category, questId)

    if not quest or not quest.rewards then
        notify(src, 'No reward found for this quest.', 'error')
        return
    end

    -- This is intentionally strict for the scaffold. Once persistent quest progress is
    -- added, replace this status check with the player's saved completion state.
    if quest.status ~= 'completed' then
        notify(src, 'Complete the quest before claiming this reward.', 'error')
        return
    end

    local ok, reason, item = Inventory.GiveRewards(src, quest.rewards)
    if not ok then
        if reason == 'ox_inventory_not_started' then
            notify(src, 'Quest rewards are unavailable because ox_inventory is not started.', 'error')
            return
        end

        if reason == 'not_enough_space' then
            notify(src, ('You do not have enough inventory space for %s.'):format(item or 'the reward'), 'error')
            return
        end

        notify(src, 'Unable to give quest reward.', 'error')
        return
    end

    notify(src, ('Reward claimed: %s'):format(quest.reward or quest.title), 'success')
end)

RegisterNetEvent('faux-questline:server:hasQuestItem', function(item, amount, metadata)
    local src = source
    TriggerClientEvent('faux-questline:client:questItemResult', src, item, Inventory.HasItem(src, item, amount, metadata))
end)

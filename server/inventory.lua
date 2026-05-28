local QBCore = exports['qb-core']:GetCoreObject()

Inventory = {}

local function useOx()
    return Config.Inventory.type == 'ox' and GetResourceState('ox_inventory') == 'started'
end

local function oxUnavailable()
    return Config.Inventory.type == 'ox' and not useOx()
end

local function getPlayer(source)
    return QBCore.Functions.GetPlayer(source)
end

function Inventory.HasItem(source, item, amount, metadata)
    amount = amount or 1

    if useOx() then
        local count = exports.ox_inventory:Search(source, 'count', item, metadata)
        return (count or 0) >= amount
    end

    if oxUnavailable() then
        return false, 'ox_inventory_not_started'
    end

    local Player = getPlayer(source)
    if not Player then return false end

    local itemData = Player.Functions.GetItemByName(item)
    return itemData and (itemData.amount or 0) >= amount
end

function Inventory.CanCarryItem(source, item, amount, metadata)
    amount = amount or 1

    if useOx() then
        return exports.ox_inventory:CanCarryItem(source, item, amount, metadata)
    end

    if oxUnavailable() then
        return false, 'ox_inventory_not_started'
    end

    return true
end

function Inventory.AddItem(source, item, amount, metadata)
    amount = amount or 1

    if useOx() then
        if not Inventory.CanCarryItem(source, item, amount, metadata) then
            return false, 'not_enough_space'
        end

        local success, response = exports.ox_inventory:AddItem(source, item, amount, metadata)
        return success == true, response
    end

    if oxUnavailable() then
        return false, 'ox_inventory_not_started'
    end

    local Player = getPlayer(source)
    if not Player then return false, 'player_not_found' end

    local success = Player.Functions.AddItem(item, amount, false, metadata)
    if success and QBCore.Shared.Items[item] then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'add', amount)
    end

    return success == true
end

function Inventory.RemoveItem(source, item, amount, metadata)
    amount = amount or 1

    if useOx() then
        local success, response = exports.ox_inventory:RemoveItem(source, item, amount, metadata)
        return success == true, response
    end

    if oxUnavailable() then
        return false, 'ox_inventory_not_started'
    end

    local Player = getPlayer(source)
    if not Player then return false, 'player_not_found' end

    local success = Player.Functions.RemoveItem(item, amount)
    if success and QBCore.Shared.Items[item] then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'remove', amount)
    end

    return success == true
end

function Inventory.AddMoney(source, amount, account, reason)
    amount = tonumber(amount) or 0
    if amount <= 0 then return true end

    if Config.Inventory.cashAsItem then
        return Inventory.AddItem(source, Config.Inventory.cashItem, amount)
    end

    local Player = getPlayer(source)
    if not Player then return false, 'player_not_found' end

    account = account or Config.Inventory.defaultMoneyAccount or 'cash'
    Player.Functions.AddMoney(account, amount, reason or 'questline-reward')
    return true
end

function Inventory.GiveRewards(source, rewards)
    if not rewards then return true end

    if rewards.items then
        for _, reward in ipairs(rewards.items) do
            local canCarry, carryReason = Inventory.CanCarryItem(source, reward.name, reward.amount or 1, reward.metadata)
            if not canCarry then
                return false, carryReason or 'not_enough_space', reward.name
            end
        end
    end

    if rewards.money then
        local ok, reason = Inventory.AddMoney(source, rewards.money.amount, rewards.money.account, 'questline-reward')
        if not ok then return false, reason end
    end

    if rewards.items then
        for _, reward in ipairs(rewards.items) do
            local ok, reason = Inventory.AddItem(source, reward.name, reward.amount or 1, reward.metadata)
            if not ok then return false, reason, reward.name end
        end
    end

    if rewards.xp then
        TriggerEvent('faux-questline:server:addXp', source, rewards.xp)
    end

    return true
end

exports('HasQuestItem', Inventory.HasItem)
exports('GiveQuestReward', Inventory.GiveRewards)

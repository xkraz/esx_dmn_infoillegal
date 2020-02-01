ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_dmn_infoillegal:buy')
AddEventHandler('esx_dmn_infoillegal:buy', function(price, x, y, z)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

-- can the player afford this item?
    if xPlayer.getMoney() >= price then
        -- can the player carry the said amount of x item?
        xPlayer.removeMoney(price)
        TriggerClientEvent('esx_dmn_infoillegal:setNewWaypoint', _source, x, y, z)
        xPlayer.showNotification("Tu as acheter un point de drogue pour ~g~" ..price.."€")
    else
        local missingMoney = price - xPlayer.getMoney()
        xPlayer.showNotification("Il te manque ~r~".. missingMoney.."€")
    end
end)
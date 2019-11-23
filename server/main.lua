ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('buyRecolteWeed')
AddEventHandler('buyRecolteWeed', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.PriceRecolte
	local PlayerData = xPlayer

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		--TriggerClientEvent('esx:showNotification', _source,  "Vous avez dépenser 50 000€")
		TriggerClientEvent('esx_dmn_infoillegal:SetWeedRecolteWaypoint', _source)
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Vendeur de points', 'Achat', 'Le point est sur ton GPS', 'CHAR_LESTER_DEATHWISH', 1)
	else
		--local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Vendeur de points', 'Argent', "Tu n'as pas assez d'argent", 'CHAR_LESTER_DEATHWISH', 1)
	end
end)

RegisterNetEvent('buyTraitementWeed')
AddEventHandler('buyTraitementWeed', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.PriceTraitement
	local PlayerData = xPlayer

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		--TriggerClientEvent('esx:showNotification', _source,  "Vous avez dépenser 50 000€")
		TriggerClientEvent('esx_dmn_infoillegal:SetWeedTraitementWaypoint', _source)
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Vendeur de points', 'Achat', 'Le point est sur ton GPS', 'CHAR_LESTER_DEATHWISH', 1)
	else
		--local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Vendeur de points', 'Argent', "Tu n'as pas assez d'argent", 'CHAR_LESTER_DEATHWISH', 1)
	end
end)

RegisterNetEvent('buyVenteWeed')
AddEventHandler('buyVenteWeed', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local price = Config.PriceVente
	local PlayerData = xPlayer

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		--TriggerClientEvent('esx:showNotification', _source,  "Vous avez dépenser 50 000€")
		TriggerClientEvent('esx_dmn_infoillegal:SetWeedVenteWaypoint', _source)
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Vendeur de points', 'Achat', 'Le point est sur ton GPS', 'CHAR_LESTER_DEATHWISH', 1)
	else
		--local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Vendeur de points', 'Argent', "Tu n'as pas assez d'argent", 'CHAR_LESTER_DEATHWISH', 1)
	end
end)
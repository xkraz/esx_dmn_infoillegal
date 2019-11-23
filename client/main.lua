ESX = nil
_menuPool = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "Vendeur d'informations")
_menuPool:Add(mainMenu)

function AddMainMenu(menu)
    weedrecolte = NativeUI.CreateItem("Point de récolte de weed", "Appuyer sur ENTRER pour payer le point")
    weedtraite = NativeUI.CreateItem("Point de traitement de weed", "Appuyer sur ENTRER pour payer le point")
    weedvente = NativeUI.CreateItem("Point de vente de weed", "Appuyer sur ENTRER pour payer le point")
    weedrecolte:RightLabel("~g~" .. Config.PriceRecolte .. "€")
    weedtraite:RightLabel("~g~" .. Config.PriceTraitement .. "€")
    weedvente:RightLabel("~g~" .. Config.PriceVente .. "€")
    menu:AddItem(weedrecolte)
    menu:AddItem(weedtraite)
    menu:AddItem(weedvente)

    menu.OnItemSelect = function(sender, item, index)
        if item == weedrecolte then
            TriggerServerEvent("buyRecolteWeed")
        end
    end
end

AddMainMenu(mainMenu)

RegisterNetEvent('esx_dmn_infoillegal:SetWeedRecolteWaypoint')
AddEventHandler('esx_dmn_infoillegal:SetWeedRecolteWaypoint', function()
    SetNewWaypoint(Config.Pos.Recolte)
end)

RegisterNetEvent('esx_dmn_infoillegal:SetWeedTraitementWaypoint')
AddEventHandler('esx_dmn_infoillegal:SetWeedTraitementWaypoint', function()
    SetNewWaypoint(Config.Pos.Traitement)
end)

RegisterNetEvent('esx_dmn_infoillegal:SetWeedVenteWaypoint')
AddEventHandler('esx_dmn_infoillegal:SetWeedVenteWaypoint', function()
    SetNewWaypoint(Config.Pos.Vente)
end)

local blips = {
    {title="Vendeur de points de weed", colour=2, id=140, x = -1112.3488769531, y = -1578.2091064453, z = 8.6795225143433}
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.9)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

local enterbuilding = {
	{x = -1112.8575439453, y = -1577.8381347656, z = 8.6795330047607},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()

        for k in pairs(enterbuilding) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, enterbuilding[k].x, enterbuilding[k].y, enterbuilding[k].z)

            if dist <= 1.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour parler au vendeur")
				if IsControlJustPressed(1,51) then 
					mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
	end
end)
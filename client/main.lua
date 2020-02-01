ESX = nil

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
mainMenu = NativeUI.CreateMenu("Willy", "Prix des points")
_menuPool:Add(mainMenu)

function AddMainMenu(menu)
    recolte = NativeUI.CreateItem("Recolte de weed", "Appuie sur ENTRER pour payer le point de recolte de weed")
    traitement = NativeUI.CreateItem("Traitement de weed", "Appuie sur ENTRER pour payer le point de traitement de weed")
    vente = NativeUI.CreateItem("Vente de weed", "Appuie sur ENTRER pour payer le point de vente de weed")
    recolte:RightLabel("~g~15000€")
    traitement:RightLabel("~g~15000€")
    vente:RightLabel("~g~15000€")
    menu:AddItem(recolte)
    menu:AddItem(traitement)
    menu:AddItem(vente)

    menu.OnItemSelect = function(sender, item, index)
        if item == recolte then
            TriggerServerEvent('esx_dmn_infoillegal:buy', 15000, -1269.35, 4458.71, 8.11)
        elseif item == traitement then
            TriggerServerEvent('esx_dmn_infoillegal:buy', 15000, -970.37, -1011.74, 1.21)
        elseif item == vente then
            TriggerServerEvent('esx_dmn_infoillegal:buy', 15000, 1570.42, -2167.0, 76.65)
        end
    end
end

AddMainMenu(mainMenu)

RegisterNetEvent('esx_dmn_infoillegal:setNewWaypoint')
AddEventHandler('esx_dmn_infoillegal:setNewWaypoint', function(x, y, z)
    SetNewWaypoint(x, y, z)
end)

-- blips

local blips = {
    {title="Vendeur de points", colour=2, id=140, x = -1112.1, y = -1578.2, z = 8.6}
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

local del = {
    {x = -1112.1, y = -1578.2, z = 8.6},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        _menuPool:ProcessMenus()
        for k in pairs(del) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, del[k].x, del[k].y, del[k].z)

            if dist <= 1.2 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour parler au ~g~vendeur~w~ de ~b~point illégal~w~")
                if IsControlJustPressed(1,38) then 
                    mainMenu:Visible(not mainMenu:Visible())
                end
            end
        end
    end
end)
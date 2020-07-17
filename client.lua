-----------------------------------------------------------------------------------------------------------------------------------------
-- 5FLEX | NOSSO DISOCRD | https://discord.gg/K3FBEFy
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES | FUNÇÃO BASICA DO SCRIPT, AONDE O ITEM SE TRANSFORMA EM OUTRO ITEM E ASSIM POR DIANTE
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

local LaV 
local marcacoes = {
	{-1614.36,-2998.22,-78.14},  -- GALAXY
	{95.07,-1292.83,29.27}  -- VANILLA
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		for _,mark in pairs(marcacoes) do
			local x,y,z,nome = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 5.0 then
				DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,0,0,100,0,0,0,1)
					if distance <= 1.2 then
						if IsControlJustPressed(0,38) then
							LaV = nome
							TriggerServerEvent('blip:lavagem',LaV)
						end
					end
			end 
		end
	end
end)
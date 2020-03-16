ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_corona:infectPlayer')
AddEventHandler('esx_corona:infectPlayer', function(playerId)
		TriggerClientEvent('esx_corona:infect', playerId)
end)

RegisterServerEvent('esx_corona:sneezeSync')
AddEventHandler('esx_corona:sneezeSync', function()
	local _source = source
	TriggerClientEvent('esx_corona:sneeze', -1, _source)
end)

ESX.RegisterUsableItem('vaccine', function(source)
	TriggerClientEvent('esx_corona:cure', source)
end)

local xPlayers = ESX.GetPlayers()
if #xPlayers >= Config.minPlayers then
	math.randomseed(os.time())
	TriggerClientEvent('esx_corona:infect', xPlayers[math.random(1, #xPlayers)])
end

function Tick()

	local xPlayers = ESX.GetPlayers()
	if #xPlayers >= Config.minPlayers then
		math.randomseed(os.time())
	print()
		TriggerClientEvent('esx_corona:infect', xPlayers[math.random(1, #xPlayers)])
	end

	SetTimeout(60000 * 100, Tick)
end

Tick()
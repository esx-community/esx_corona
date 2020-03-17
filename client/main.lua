local isInfected = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_corona:cure')
AddEventHandler('esx_corona:cure', function()
	isInfected = false
	SetTimecycleModifierStrength(0.0)
	ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.0)
	SetPedMotionBlur(PlayerPedId(), false)
	Citizen.Wait(5000)
	local chanceToDie = math.random(0, 100)

	if chanceToDie > (100 - 95) then
		SetEntityHealth(PlayerPedId(), 0)
	end
end)

RegisterNetEvent('esx_corona:infect')
AddEventHandler('esx_corona:infect', function()
	if Config.useMask then
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin['mask_1'] == 0 then
				isInfected = true
			end
		end)
	else
		isInfected = true
	end
end)

RegisterNetEvent('esx_corona:sneeze')
AddEventHandler('esx_corona:sneeze', function(playerId)
	local playerPed = GetPlayerPed(GetPlayerFromServerId(playerId))
	local particleDictionary = "cut_bigscr"
	local particleName = "cs_bigscr_beer_spray"

	RequestNamedPtfxAsset(particleDictionary)

	while not HasNamedPtfxAssetLoaded(particleDictionary) do
		Citizen.Wait(1)
	end

	SetPtfxAssetNextCall(particleDictionary)
	local bone = GetPedBoneIndex(playerPed, 47495)
	local effect = StartParticleFxLoopedOnPedBone(particleName, playerPed, -0.1, 0.5, 0.5, -90.0, 0.0, 20.0, bone, 1.0, false, false, false)
	Citizen.Wait(1000)
	local effect2 = StartParticleFxLoopedOnPedBone(particleName, playerPed, -0.1, 0.5, 0.5, -90.0, 0.0, 20.0, bone, 1.0, false, false, false)
	Citizen.Wait(3500)
	StopParticleFxLooped(effect, 0)
	StopParticleFxLooped(effect2, 0)
end)

Citizen.CreateThread(function()
	local playerPed = PlayerPedId()

	while true do
		math.randomseed(GetGameTimer())
		Citizen.Wait(math.random(Config.minTime, Config.maxTime))

		if isInfected then
			ESX.Streaming.RequestAnimDict("timetable@gardener@smoking_joint", function()
				TaskPlayAnim(playerPed, "timetable@gardener@smoking_joint", "idle_cough", 8.0, 8.0, -1, 50, 0, false, false, false)
				Citizen.Wait(1400)
				TriggerServerEvent('esx_corona:sneezeSync')
				Citizen.Wait(2600)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer ~= -1 and closestDistance < 4.0 then
					TriggerServerEvent('esx_corona:infectPlayer', GetPlayerServerId(closestPlayer))
				end

				Citizen.Wait(1000)
				SetTimecycleModifierStrength(0.1)
				SetTimecycleModifier("BikerFilter")
				SetPedMotionBlur(playerPed, true)
				ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.1)
				local health = GetEntityHealth(playerPed)
				local newHealth = health - 1
				SetEntityHealth(playerPed, newHealth)
				ClearPedSecondaryTask(playerPed)
				local chanceToRagdoll = math.random(0, 100)

				if chanceToRagdoll > (100 - Config.chanceToRagdoll) then
					SetPedToRagdoll(playerPed, 6000, 6000, 0, 0, 0, 0)
				end
			end)
		end
	end
end)

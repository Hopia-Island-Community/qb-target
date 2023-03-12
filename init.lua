QBCore = exports['qb-core']:GetCoreObject()
function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {}

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 7.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Whether to have the target as a toggle or not
Config.Toggle = false

-- Draw a Sprite on the center of a PolyZone to hint where it's located
Config.DrawSprite = false

-- The default distance to draw the Sprite
Config.DrawDistance = 10.0

-- The color of the sprite in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.DrawColor = {255, 255, 255, 255}

-- The color of the sprite in rgb when the PolyZone is targeted, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.SuccessDrawColor = {30, 144, 255, 255}

-- The color of the outline in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.OutlineColor = {255, 255, 255, 255}

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = true

-- Disable the target eye whilst being in a vehicle
Config.DisableInVehicle = true

-- Key to open the target eye, here you can find all the names: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKey = 'LMENU' -- Left Alt

-- Control for key press detection on the context menu, it's the Right Mouse Button by default, controls are found here https://docs.fivem.net/docs/game-references/controls/
Config.MenuControlKey = 238

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {
	["lsfd_storage"] = {
		name="lsfd_storage",
		coords = vector3(1211.13, -1488.5, 34.69),
		length = 0.6,
		width = 1.5,
		heading=0,
		--debugPoly=true,
		minZ=33.69,
		maxZ=35.89,
		options = {
			{
				icon = "fas fa-clipboard",
				label = "Armoire à équipement",
				job = "lsfd",
				action = function ()
					TriggerEvent("qb-storage:client:openStorage", "LSFD_stash")
				end
			}
		},
		distance = 2.5,
	},
	["lsfd_vestiary"] = {
		name="lsfd_vestiary",
		coords = vector3(1232.3, -1491.28, 34.69),
		length = 7.2,
		width = 0.4,
		heading=0,
		--debugPoly=true,
		minZ=33.69,
		maxZ=35.69,
		options = {
			{
				type = "client",
				event = "qb-clothing:client:openOutfitMenu",
				icon = "fa-solid fa-shirt",
				label = "Vestiaire",
				job = "lsfd",
			}
		},
		distance = 2.5,
	},
	["mechanic_vestiary"] = {
		name="mechanic_vestiary",
		coords = vector3(-195.29, -1332.14, 30.89),
		length = 5,
		width = 1,
		heading=0,
		--debugPoly=true,
		minZ=28.49,
		maxZ=32.49,
		options = {
			{
				type = "client",
				event = "qb-clothing:client:openOutfitMenu",
				icon = "fa-solid fa-shirt",
				label = "Vestiaire",
				--job = "mechanic",
			}
		},
		distance = 2.5,
	},
	["taxi_vestiary"] = {
		name="taxi_vestiary",
		coords = vector3(894.04, -163.13, 76.9),
		length = 3,
		width = 1,
		heading=328,
		--debugPoly=true,
		minZ=74.1,
		maxZ=78.1,
		options = {
			{
				type = "client",
				event = "qb-clothing:client:openOutfitMenu",
				icon = "fa-solid fa-shirt",
				label = "Vestiaire",
				--job = "taxi",
			}
		},
		distance = 2.5,
	},

}

Config.PolyZones = {

}

Config.TargetBones = {

}

Config.TargetModels = {
	--[[ ["Tuner"] = {
		models = {
			"a_m_m_og_boss_01",
		},
		options = {
			{
				type = "client",
				event = "tuner-jobcrafting:Menu1",
				icon = "fas fa-truck-monster",
				label = "Fabriquer des pièces",
			},
		},
		distance = 2.5,
	}, ]]
	--PDP
	["reception"] = {
		models = {
			"s_f_y_cop_01",
		},
		options = {
			{
				type = "client",
				event = "qb-policejob:ToggleDuty",
				icon = "fas fa-clipboard",
				label = "Prendre son service",
				job = "police",
				canInteract = function()
					return not QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
			{
				type = "client",
				event = "qb-policejob:ToggleDuty",
				icon = "fas fa-clipboard",
				label = "Finir son service",
				job = "police",
				canInteract = function()
					return QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
		},
		distance = 2.5,
	},
	["armurerie"] = {
		models = {
			"s_m_y_cop_01",
		},
		options = {
			{
				icon = "fas fa-clipboard",
				label = "Armurerie",
				job = "police",
				canInteract = function()
					return QBCore.Functions.GetPlayerData().job.onduty
				end,
				action = function ()
					TriggerEvent("qb-storage:client:openStorage", "police_armory")
				end
			},
		},
		distance = 2.5,
	},
	--[[ ["garage"] = {
		models = {
			"s_m_m_armoured_02",
		},
		options = {
			{
				type = "client",
				event = "police:client:VehicleMenuHeader",
				icon = "fas fa-truck-monster",
				label = "Garage",
			},
		},
		distance = 2.5,
	}, ]]

	--FireJob
	["targetmodel2"] = {
		models = {
			"s_m_y_fireman_01"
			--"s_m_m_dockwork_01"
		},
		options = {
			{
				type = "client",
				event = "qb-firejob:toolsmenu",
				icon = "fas fa-fire-extinguisher",
				label = "FireFighter Menu",
				job = 'lsfd'
			},
			{
				type = "client",
				event = "Toggle:LSFDDuty",
				icon = "fas fa-clipboard",
				label = "Prendre son service",
				job = "lsfd",
				canInteract = function()
					return not QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
			{
				type = "client",
				event = "Toggle:LSFDDuty",
				icon = "fas fa-clipboard",
				label = "Finir son service",
				job = "lsfd",
				canInteract = function()
					return QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
			{
				type = "client",
				event = "qb-clothing:client:openOutfitMenu",
				icon = "fa-solid fa-clothes-hanger",
				label = "Vestiaire",
				job = "lsfd",
				canInteract = function()
					return QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
		},
		distance = 2.5,
	},

	["hydrant"] = {
		models = {200846641, 687935120, -366155374, -97646180},
		options = {
			{
				type = 'client',
				event = 'qb-firejob:Connect',
				icon = 'fas fa-fire-extinguisher',
				label = 'Connect to Hydrant'
			},
			{
				type = 'client',
				event = 'qb-firejob:Disconnect',
				icon = 'fas fa-fire-extinguisher',
				label = 'Disconnect from Hydrant'
			}
		},
		distance = 2.0
	},
	["tug_rental"] = {
		models = {
			"a_m_m_hillbilly_01",
		},
		options = {
			{
				type = "client",
				event = "qb-rental:openMenu",
				category = "tug",
				icon = "fas fa-car",
				label = "Location de véhicules",
			},
		},
		distance = 4.0
	},
	["jetski_rental"] = {
		models = {
			"a_m_y_business_03",
		},
		options = {
			{
				type = "client",
				event = "qb-rental:openMenu",
				category = "jetski",
				icon = "fas fa-car",
				label = "Location de véhicules",
			},
		},
		distance = 4.0
	},
	["VehicleRental"] = {
		models = {
			"a_m_y_business_02",
		},
		options = {
			{
				type = "client",
				event = "qb-rental:openMenu",
				category = "shop2",
				icon = "fas fa-car",
				label = "Location de véhicules",
			},
		},
		distance = 4.0
	},
	["HopitalDuty"] = {
		models = {
			"s_m_m_paramedic_01",
		},
		options = {
			{
				type = "client",
				event = "EMSToggle:Duty",
				icon = "fas fa-bed",
				label = "Prendre son service",
				job = "ambulance",
				canInteract = function()
					return not QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
			{
				type = "client",
				event = "EMSToggle:Duty",
				icon = "fas fa-clipboard",
				label = "Finir son service",
				job = "ambulance",
				canInteract = function()
					return QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
		},
		distance = 4.0
	},
	["HopitalCheckIn"] = {
		models = {
			"s_m_y_autopsy_01",
		},
		options = {
			{
				type = "client",
				event = "qb-ambulancejob:checkin",
				icon = "fas fa-clipboard",
				label = "S'enregistrer",
			},

		},
		distance = 4.0
	},
	["TaxiDuty"] = {
		models = {
			"a_m_m_indian_01",
		},
		options = {
			{
				type = "server",
				event = "QBCore:ToggleDuty",
				icon = "fas fa-clipboard",
				label = "Prendre son service",
				job = "taxi",
				canInteract = function()
					return not QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
			{
				type = "server",
				event = "QBCore:ToggleDuty",
				icon = "fas fa-clipboard",
				label = "Finir son service",
				job = "taxi",
				canInteract = function()
					return QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
		},
		distance = 4.0
	},
	["Hopia-Trading"] = {
		models = {
			"a_m_y_gay_02",
		},
		options = {
			{
				type = 'client',
				event = 'Hopia-Trading:client:openMenu',
				icon = 'fas fa-ring',
				label = 'Hopia-Trading',
			},
		},
		distance = 4.0
	},
	["insidetrack"] = {
		models = {
			'S_M_Y_Doorman_01',
		},
		options = {
			{
				type = "client",
				event = "QBCore:client:openInsideTrack",
				icon = "fas fa-coins",
				label = "Course de chevaux",
			},
		},
		distance = 3.5
	},
	["casinobar"] = {
		models = {
			's_m_m_highsec_01',
		},
		options = {
			{
				type = "client",
				event = "qb-shops:marketshop",
				icon = "fas fa-beer",
				label = "Open bar",
			},
		},
		distance = 3.0
	},
	["hopiamotor"] = {
		models = {
			'a_f_y_femaleagent',
		},
		options = {
			{
				type = "server",
				event = "QBCore:ToggleDuty",
				icon = "fas fa-clipboard",
				label = "Prendre son service",
				job = "cardealer",
				canInteract = function()
					return not QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
			{
				type = "server",
				event = "QBCore:ToggleDuty",
				icon = "fas fa-clipboard",
				label = "Finir son service",
				job = "cardealer",
				canInteract = function()
					return QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
		},
		distance = 3.0
	},
	["mecano_temp"] = {
		models = {
			's_m_m_autoshop_02',
		},
		options = {
			{
				type = "server",
				event = "QBCore:ToggleDuty",
				icon = "fas fa-clipboard",
				label = "Prendre son service",
				job = "mechanic",
				canInteract = function()
					return not QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
			{
				type = "server",
				event = "QBCore:ToggleDuty",
				icon = "fas fa-clipboard",
				label = "Finir son service",
				job = "mechanic",
				canInteract = function()
					return QBCore.Functions.GetPlayerData().job.onduty
				end,
			},
		},
		distance = 3.0
	},
}

Config.GlobalPedOptions = {

}

Config.GlobalVehicleOptions = {

}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {

}

Config.Peds = {
	--PDP
	-- Récéption
	{
		model = 's_f_y_cop_01',
		coords = vector4(-1097.73, -839.66, 18.0, 118.93),
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 's_m_y_cop_01',
		coords = vector4(-1099.94, -824.76, 13.28, 214.9),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	-- Garage
	{
		model = 's_m_m_armoured_02',
		coords = vector4(-1071.18, -844.7, 3.88, 116.92),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	--FireJob
	{
		model = 's_m_y_fireman_01',
		--model = 's_m_m_dockwork_01',
		coords = vector4(1186.85, -1483.39, 33.69, 350.24),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	--Location Véhicules
	--{
	--	model = 'a_m_y_business_03',
	--	coords = vector4(290.84, -227.63, 52.98, 173.17),
	--	gender = 'male',
	--	freeze = true,
	--	invincible = true,
	--	blockevents = true,
	--},
	{
		model = 's_m_y_autopsy_01',
		coords = vector4(-1850.8, -337.71, 48.45, 152.21),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 's_m_m_paramedic_01',
		coords = vector4(-1852.56, -336.37, 48.45, 132.2),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 's_m_m_scientist_01',
		coords = vector4(-1830.07, -380.88, 48.4, 51.49),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'a_m_m_indian_01',
		coords = vector4(901.34, -170.06, 73.08, 228.81),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
		animDict = 'abigail_mcs_1_concat-0',
		anim = 'csb_abigail_dual-0',
		flag = 1,
		scenario = 'WORLD_HUMAN_AA_COFFEE',
	},
	{
		model = 'a_m_y_gay_02',
		coords = vector4(-621.3, -1640.53, 24.97, 142.99),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
		scenario = 'WORLD_HUMAN_SMOKING',
	},
	{
		model = 'a_f_y_femaleagent',
		coords = vector4(-781.83, -210.8, 36.15, 117.05),
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
		--scenario = 'WORLD_HUMAN_AA_COFFEE',
	},
	{
		model = 's_m_m_autoshop_02',
		coords = vector4(-206.49, -1333.72, 29.91, 173.81),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
		--scenario = 'WORLD_HUMAN_AA_COFFEE',
	},
}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
local function JobCheck() return true end
local function GangCheck() return true end
local function JobTypeCheck() return true end
local function ItemCheck() return true end
local function CitizenCheck() return true end

CreateThread(function()
	local state = GetResourceState('qb-core')
	if state ~= 'missing' then
		local timeout = 0
		while state ~= 'started' and timeout <= 100 do
			timeout += 1
			state = GetResourceState('qb-core')
			Wait(0)
		end
		Config.Standalone = false
	end
	if Config.Standalone then
		local firstSpawn = false
		local event = AddEventHandler('playerSpawned', function()
			SpawnPeds()
			firstSpawn = true
		end)
		-- Remove event after it has been triggered
		while true do
			if firstSpawn then
				RemoveEventHandler(event)
				break
			end
			Wait(1000)
		end
	else
		local QBCore = exports['qb-core']:GetCoreObject()
		local PlayerData = QBCore.Functions.GetPlayerData()

		ItemCheck = QBCore.Functions.HasItem

		JobCheck = function(job)
			if type(job) == 'table' then
				job = job[PlayerData.job.name]
				if job and PlayerData.job.grade.level >= job then
					return true
				end
			elseif job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end

		JobTypeCheck = function(jobType)
			if type(jobType) == 'table' then
				jobType = jobType[PlayerData.job.type]
				if jobType then
					return true
				end
			elseif jobType == 'all' or jobType == PlayerData.job.type then
				return true
			end
			return false
		end

		GangCheck = function(gang)
			if type(gang) == 'table' then
				gang = gang[PlayerData.gang.name]
				if gang and PlayerData.gang.grade.level >= gang then
					return true
				end
			elseif gang == 'all' or gang == PlayerData.gang.name then
				return true
			end
			return false
		end

		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.citizenid or citizenid[PlayerData.citizenid]
		end

		RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
			PlayerData = QBCore.Functions.GetPlayerData()
			SpawnPeds()
		end)

		RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
			PlayerData = {}
			DeletePeds()
		end)

		RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
			PlayerData.job = JobInfo
		end)

		RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
			PlayerData.gang = GangInfo
		end)

		RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
			PlayerData = val
		end)
	end
end)

function CheckOptions(data, entity, distance)
	if distance and data.distance and distance > data.distance then return false end
	if data.job and not JobCheck(data.job) then return false end
	if data.excludejob and JobCheck(data.excludejob) then return false end
	if data.jobType and not JobTypeCheck(data.jobType) then return false end
	if data.excludejobType and JobTypeCheck(data.excludejobType) then return false end
	if data.gang and not GangCheck(data.gang) then return false end
	if data.excludegang and GangCheck(data.excludegang) then return false end
	if data.item and not ItemCheck(data.item) then return false end
	if data.citizenid and not CitizenCheck(data.citizenid) then return false end
	if data.canInteract and not data.canInteract(entity, distance, data) then return false end
	return true
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("round/cl_controller.lua")

include("cvars.lua")
include("shared.lua")
include("round/sv_controller.lua")

-- Teams

team.SetUp(1, "Innocent", Color(125, 125, 125, 255))
team.SetUp(2, "Traitor", Color(125, 125, 125, 255))
team.SetUp(3, "Spectator", Color(0, 0, 0, 0))

-- Joining events

function GM:PlayerConnect(name, ip)
	print("Player " .. name .. " connected")
end

function GM:PlayerInitialSpawn(ply)
	-- Set all new players to spectators
	ply:SetTeam(3)
	ply:Spectate(0)
	print("Player " .. ply:Name() .. " joined")
end
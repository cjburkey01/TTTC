-- States:
--   0: Too few players
--   1: Pre-round
--   2: In-round
--   3: Post-round
local state = 0

-- In seconds
local roundTime = 0
local timeSinceLastClientTimeUpdate = 0

function GetRoundStatus()
	return state
end

function GetRoundTime()
	return roundTime
end

-- Handler

util.AddNetworkString("UpdateRoundStatus")
util.AddNetworkString("UpdateRoundTime")

hook.Add("Think", "OnTick", function()
	local plys = player.GetCount()
	if plys < GetMinPlayers() and state == 2 then
		EndRound()
	end
	if state == 0 and plys >= GetMinPlayers() and roundTime >= GetPreRoundTime() then
		StartPreRound()
	elseif state == 1 and plys >= GetMinPlayers() then
		StartRound();
	elseif state == 2 and roundTime >= GetMaxRoundTime() then
		EndRound()
	elseif state == 3 and plys >= GetMinPlayers() and roundTime >= GetPostRoundTime() then
		StartPreRound()
	end
	UpdateRoundTime()
end)

function SetTooFewPlayers()
	SetRound(0)
end

function StartPreRound()
	SetRound(1)
end

function StartRound()
	SetRound(2)
end

function EndRound()
	SetRound(3)
end

-- Utility functions

function SetRound(s)
	for k,v in pairs(player.GetAll()) do
		if s == 0 then
			v:Spectate(5)
			v:SetTeam(3)
		elseif s == 1 then
			v:UnSpectate()
			v:Spectate(0)
			v:SetTeam(1)
		elseif s == 2 then
			v:UnSpectate()
			v:Spectate(0)
			v:SetTeam(1)
		elseif s == 3 then
			v:Spectate(5)
			v:SetTeam(1)
		end
	end
	state = s
	roundTime = 0
	UpdateClientStatus()
	UpdateClientTime()
end

function UpdateRoundTime()
	roundTime = roundTime + FrameTime()
	timeSinceLastClientTimeUpdate = timeSinceLastClientTimeUpdate + FrameTime()
	if timeSinceLastClientTimeUpdate >= 0.5 then
		UpdateClientTime()
	end
	print(roundTime)
end

-- Network functions

function UpdateClientStatus()
	net.Start("UpdateRoundStatus")
	net.WriteInt(state, 4)
	net.Broadcast()
end

function UpdateClientTime()
	net.Start("UpdateRoundTime")
	net.WriteFloat(roundTime)
	net.Broadcast()
end
local minPlayers = 0
local maxRoundTime = 0
local preRoundTime = 0

CreateConVar("tttc_min_players", 2, FCVAR_NONE, "The minimum number of players for a round to begin")
CreateConVar("tttc_round_time", 300, FCVAR_NONE, "The length in seconds of a round")
CreateConVar("tttc_round_start_time", 30, FCVAR_NONE, "The length in seconds of the pre-round state")

cvars.AddChangeCallback("tttc_min_players", function(cvar, ov, nv)
	minPlayers = nv
end)

cvars.AddChangeCallback("tttc_round_time", function(cvar, ov, nv)
	maxRoundTime = nv
end)

cvars.AddChangeCallback("tttc_round_start_time", function(cvar, ov, nv)
	preRoundTime = nv
end)

function GetMinPlayers()
	return minPlayers
end

function GetMaxRoundTime()
	return maxRoundTime
end

function GetPreRoundTime()
	return preRoundTime
end
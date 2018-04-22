local status = 0
local roundTime = 0

net.Receive("UpdateRoundStatus", function(length)
	status = net.ReadInt(length)
end)

net.Receive("UpdateRoundTime", function(length)
	roundTime = net.ReadFloat(length)
	print("Timer!")
end)

function GetRoundStatus()
	return status
end

function GetRoundTime()
	return roundTime
end
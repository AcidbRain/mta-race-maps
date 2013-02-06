
addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint", getRootElement(),
	function(checkpointNum, time)
		if checkpointNum == 12 then
			local vehicle = getPedOccupiedVehicle(source)
			local vx, vy, vz = getElementVelocity(vehicle)
			setElementVelocity(vehicle, vx * 6, vy * 6, vz)
			triggerClientEvent(source, "onResourcePlaySound", source, "turbo.ogg")
		end
	end
)
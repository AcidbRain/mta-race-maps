g_raceIsSetVehicleIDExported = false

local switchPoint = {
	[11] = { 451, 415 }
}

function findResourceCaps()
	local raceResource = getResourceFromName("race")
	if not raceResource then return end
	
	local functionNames = getResourceExportedFunctions(raceResource)
	if type(functionNames) ~= "table" then return end
	
	for _,name in ipairs(functionNames) do
		if name == "setVehicleID" then
			g_raceIsSetVehicleIDExported = true
			break
		end
	end

end
addEventHandler("onResourceStart", resourceRoot, findResourceCaps)


function setVehicleID(vehicle, id)
	if g_raceIsSetVehicleIDExported then
		exports["race"]:setVehicleID(vehicle, id)
	else
		setElementModel(vehicle, id)
	end
end


addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint", root,
	function(checkpointNum, time)
		local switchData = switchPoint[checkpointNum]
		if not switchData then return end
		
		local vehicle = getPedOccupiedVehicle(source)
		if not vehicle then return end

		local modelId = getElementModel(vehicle)
		if modelId == switchData[1] then
			modelId = switchData[2]
		elseif modelId == switchData[2] then
			modelId = switchData[1]
		else
			return
		end
		setVehicleID(vehicle, modelId)
	end
)
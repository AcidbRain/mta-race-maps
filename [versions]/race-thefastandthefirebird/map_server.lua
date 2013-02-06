g_ResRoot = getResourceRootElement()

g_AccelTimer = nil
g_SpawnTimer = nil

g_TrainOptions =  {
	TrainCount = 10,
	Acceleration = 0.00225,
	AccelerationDelay = 250,
	MaxSpeed = 0.5
}

g_TrainIndex = 0
g_TrainSpeed = { }

function setTrainMotion(train, index)
	setTrainSpeed(train, g_TrainSpeed[index])
	if g_TrainSpeed[index] < g_TrainOptions.MaxSpeed then
		g_TrainSpeed[index] = g_TrainSpeed[index] + g_TrainOptions.Acceleration
	end
end

function spawnTrain()
	g_TrainIndex = g_TrainIndex + 1
	local train = createVehicle(537, 1394, 2632, 10)
	if train then
		g_TrainSpeed[g_TrainIndex] = 0
		setVehicleEngineState(train, true)
		setTrainDerailable(train, false)
		setVehicleDamageProof(train, true)
		setElementData(train, "Vehicle.Collidable", 1)
		setTimer(setTrainMotion, g_TrainOptions.AccelerationDelay, 0, train, g_TrainIndex)
	end
end


function Initialize()
	-- spawn the first train
	spawnTrain()
	
	g_SpawnTimer = setTimer(spawnTrain, 3500, (g_TrainOptions.TrainCount - 1) or 1)
end
addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", getRootElement(), 
	function(newState, oldState)
		if newState == "Running" and oldState == "GridCountdown" then
			Initialize()
		end
	end
)



-- HANDLER for 'onResourceStart'
--
function CacheResourceSettings()
	g_TrainOptions.TrainCount = tonumber(get("*race-thefastandthefirebird.train_count")) or 10
	g_TrainOptions.Acceleration = tonumber(get("*race-thefastandthefirebird.acceleration")) or 0.00225
	g_TrainOptions.AccelerationDelay = tonumber(get("*race-thefastandthefirebird.acceleration_period")) or 250
	g_TrainOptions.MaxSpeed = tonumber(get("*race-thefastandthefirebird.max_speed")) or 0.5
end
addEventHandler('onResourceStart', g_ResRoot, CacheResourceSettings)


-- HANDLER for 'onResourceStop'
--
function Dispose()
	if g_AccelTimer then killTimer(g_AccelTimer) end
	if g_SpawnTimer then killTimer(g_SpawnTimer) end
end
addEventHandler('onResourceStop', g_ResRoot, Dispose)
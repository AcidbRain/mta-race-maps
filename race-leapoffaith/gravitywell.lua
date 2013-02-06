local zone = nil
local me = getLocalPlayer()
local tmodelId = 432
local tanks = {
	{ x=1439.8310546875, y=1456.5260009766, z=140 },
	{ x=1425.9813232422, y=1456.5260009766, z=140 },
	{ x=1425.9813232422, y=1471.0397949219, z=140 },
	{ x=1439.8310546875, y=1471.0397949219, z=140 },
	{ x=1432.4310546875, y=1463.5397949219, z=150 },
	{ x=1432.4310546875, y=1463.5397949219, z=140 },
}
local mines = {}

function enterGravityWell(element, dimension)
	if element == getPedOccupiedVehicle(me) then
		setVehicleGravity(element, 0, 0, 0)
		setGameSpeed(0.9995)
	elseif element == me then
		setGravity(0.004)
	end
end

function leaveGravityWell(element, dimension)
	if element == getPedOccupiedVehicle(me) then
		setVehicleGravity(element, 0, 0, -1)
		setGameSpeed(1)
	elseif element == me then
		setGravity(0.008)
	end
end

function layoutMines()
	local x = 1403
	local y = 1433
	local z = 36
	local sx = 60
	local sy = 60
	local step = 4.5
	local c = 1
	while (sy > 0) do
		while (sx > 0) do
			if mines[c] then
				destroyElement(mines[c])
			end
			mines[c] = createObject(2918, x, y, z)
			c = c + 1
			x = x + step
			sx = sx - step
		end
		y = y + step
		sy = sy - step
		sx = 60
		x = 1403
	end
	
	for i,t in ipairs(tanks) do 
		if t.waste then
			destroyElement(t.waste)
			t.waste = nil
		end
	end
end

function spawnTank(t)
	t.vehicle = createVehicle(tmodelId, t.x, t.y, t.z)
	setElementRotation(t.vehicle, math.random(180), math.random(180), math.random(360))
	setVehicleTurnVelocity(t.vehicle, math.random(), math.random(), math.random())
	setVehicleDamageProof(t.vehicle, true)
end


function setupTanks()
	for i,t in ipairs(tanks) do 
		spawnTank(t)
	end
	addEventHandler("onClientPreRender", root, 
		function()
			for i,t in ipairs(tanks) do 
				local x,y,z = getElementPosition(t.vehicle)
				if z < 30 then
					destroyElement(t.vehicle)
					spawnTank(t)
				elseif x<1403 or x>1463 or y<1433 or y>1493 then
					blowVehicle(t.vehicle, true)
					t.waste = t.vehicle
					spawnTank(t)
				end
			end
		end
	)
end

addEventHandler("onClientPlayerVehicleEnter", root,
	function(vehicle, seat)
		leaveGravityWell(vehicle, dimension)
		leaveGravityWell(me, dimension)
	end
)

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		zone = createColRectangle(1403.36328125, 1433.9588623047, 60, 60)
		addEventHandler("onClientColShapeHit", zone, enterGravityWell)
		addEventHandler("onClientColShapeLeave", zone, leaveGravityWell)
		layoutMines()
		setupTanks()
		setTimer(layoutMines, 20000, 0)
	end
)



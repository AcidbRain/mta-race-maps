
function cruiseControl(pilot)
	setPedControlState(pilot, "steer_back", false)
	setPedControlState(pilot, "accelerate", false)
	setPedControlState(pilot, "sub_mission", true)
	setPedControlState(pilot, "accelerate", true)
	setPedControlState(pilot, "sub_mission", false)
end

function startDestroyPlane(plane)
	setTimer(destroyPlane, 750, 40, plane)
end

function destroyPlane(plane)
	local x, y, z = getElementPosition(plane)
	createExplosion(x, y, z, 0)
end

addEvent("onPedStartPiloting", true)
addEventHandler("onPedStartPiloting", root, 
	function(pilot, plane)
		setPedControlState(pilot, "accelerate", true)
		setPedControlState(pilot, "steer_back", true)
		
		setTimer(cruiseControl, 4500, 1, pilot)
		setTimer(startDestroyPlane, 6000, 1, plane)
	end
)
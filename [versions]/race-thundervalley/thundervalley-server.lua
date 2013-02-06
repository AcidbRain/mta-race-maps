
function StartAndromada()
	local andromada = getElementByID("ANDROMADA")
	if not andromada then
		outputDebugString("No plane")
		return
	end
	setVehicleEngineState(andromada, true)
	
	local x, y, z = getElementPosition(andromada)
	local pilot = createPed(255,x,y,z)
	if pilot then
		warpPedIntoVehicle(pilot, andromada)
		triggerClientEvent("onPedStartPiloting", root, pilot, andromada)
	end
end


addEvent("onRaceStateChanging")
addEventHandler("onMapStarting", root,
	function()
		setTimer(StartAndromada, 2000, 1)
	end
)

local removers = { 
	-- junkyard airplanes
	{
		x = 231,
		y = 2616,
		z = 25,
		radius = 100,
		models = { 3270, 3368, 3271, 3367, 3269, 3369 }
	},
	-- rocks
	{
		x = 275,
		y = 2671,
		z = 35,
		radius = 50,
		models = { 16675, 16707 }
	},
	-- torenos outpost 
	{
		x = 264,
		y = 2884,
		z = 15,
		radius = 20,
		models = { 3362, 3350 }
	},
}

function restoreCameras()
	for _,player in ipairs(getElementsByType("player")) do
		setCameraTarget(player)
	end
end

function moveCamerasAway()
	for _,player in ipairs(getElementsByType("player")) do
		setCameraMatrix(player, 3000, 3000, 3000)
	end
end

addEventHandler("onResourceStart", resourceRoot,
	function()
		moveCamerasAway()
		for _,remover in ipairs(removers) do
			for _,model in ipairs(remover.models) do
				removeWorldModel(model, remover.radius, remover.x, remover.y, remover.z)
			end
		end
		setTimer(restoreCameras, 1000, 1)
	end
)

addEventHandler("onResourceStop",resourceRoot,
	function()
		moveCamerasAway()
		for _,remover in ipairs(removers) do
			for _,model in ipairs(remover.models) do
				restoreWorldModel(model, remover.radius, remover.x, remover.y, remover.z)
			end
		end		
		setTimer(restoreCameras, 1000, 1)
	end
)
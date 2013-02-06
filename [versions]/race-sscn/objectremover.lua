local removers = { 
	{
		x = 1230,
		y = 2570,
		z = 12,
		radius = 20,
		models = { 858, 904 }
	}
}

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		setCameraMatrix(3000, 3000, 3000)
		for _,remover in ipairs(removers) do
			for _,model in ipairs(remover.models) do
				removeWorldModel(model, remover.radius, remover.x, remover.y, remover.z)
			end
		end
		setTimer(setCameraTarget, 1000, 1, localPlayer)
	end
)

addEventHandler("onClientResourceStop",resourceRoot,
	function()
		setCameraMatrix(3000, 3000, 3000)
		for _,remover in ipairs(removers) do
			for _,model in ipairs(remover.models) do
				restoreWorldModel(model, remover.radius, remover.x, remover.y, remover.z)
			end
		end		
		setTimer(setCameraTarget, 1000, 1, localPlayer)
	end
)

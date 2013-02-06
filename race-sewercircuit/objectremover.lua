local removers = { 
	{
		x = 1580,
		y = -1674,
		z = 16,
		radius = 200,
		models = { 4090, 4096, 1283, 1294, 1226, 1229 }
	},
	{
		x = 1489,
		y = -1798,
		z = 10,
		radius = 100,
		models = { 3997, 4045, 700, 673, 620, 4172, 4173, 4174, 4175 }
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
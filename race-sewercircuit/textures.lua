addEventHandler("onClientResourceStart", resourceRoot, 
	function()
		local txd = engineLoadTXD("vgssland01.txd")
		engineImportTXD(txd, 8171)
		engineImportTXD(txd, 8344)
	end
)
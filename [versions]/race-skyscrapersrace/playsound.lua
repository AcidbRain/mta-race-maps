local player = getLocalPlayer()

addEvent("onResourcePlaySound", true)
addEventHandler("onResourcePlaySound", player, 
	function(soundfile)
		playSound(soundfile)
	end
)

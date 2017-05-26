bg = new BackgroundLayer

# Framer.Defaults.Animation =
# 	curve: "spring(200,20,0)"

toggleSize = 200
borderWidth = 6
toggleRadius = toggleSize / 1.7
thumbSize = toggleSize / 1.7 - borderWidth * 2
thumbGrow = thumbSize * 0.2
white	= "FFFFFF"
silver	= "E5E5E5"
active	= "4CD964"

toggle = new Layer
	width: toggleSize
	height: toggleRadius
	borderRadius: toggleRadius
	borderWidth: borderWidth
	borderColor: silver
	backgroundColor: silver

toggle.center()

toggleBkgd = new Layer
	superLayer: toggle
	width: toggle.width - borderWidth * 2
	height: toggle.height - borderWidth * 2
	borderRadius: toggle.height / 2 - borderWidth
	backgroundColor: white

toggleBkgd.center()

thumb = new Layer
	superLayer: toggle
	y: 0
	borderRadius: thumbSize / 2
	backgroundColor: white
	height: thumbSize
	width: thumbSize
	shadowY: thumbSize / 30
	shadowBlur: thumbSize / 20
	shadowSpread: thumbSize / 30
	shadowColor: "rgba(0,0,0,0.2)"

toggleBkgd.states.animationOptions = 
	time: 0.3
	
toggleBkgd.states.minimize =
	scale: 0

toggleBkgd.states.active =
	scale: 1
	backgroundColor: active

toggle.states.active =
	borderColor: active

thumb.states.animationOptions =
	curve: "spring(200,20,10)"

thumb.states.off =
	x: 0
	width: thumbSize

thumb.states.on =
	x: toggleSize - thumbSize - borderWidth * 2
	width: thumbSize

thumb.stateSwitch "off"

thumb.on Events.TouchStart, ->
	if thumb.states.current.name == "on"
		thumb.animate
			width: thumbSize + thumbGrow
			x: toggleSize - thumbSize - thumbGrow - borderWidth * 2
	else
		toggleBkgd.animate "minimize"
		thumb.animate
			width: thumbSize + thumbGrow

thumb.on Events.SwipeRight, ->
	if thumb.states.current.name == "off"
		toggle.stateSwitch "active"
		toggleBkgd.stateSwitch "active"
	
	thumb.animate "on"

thumb.on Events.SwipeLeft, ->
	if thumb.states.current.name == "on"
		toggle.stateSwitch "default"
		toggleBkgd.stateSwitch "default"
		toggleBkgd.scale = 0
	
	toggleBkgd.animate
		scale: 1
	thumb.animate "off"

thumb.on Events.TouchEnd, ->
	newState = if thumb.states.current.name == "off" then "on" else "off"
	if thumb.width > thumbSize
		thumb.animate newState
		
		if newState == "on"
			toggle.stateSwitch "active"
			toggleBkgd.stateSwitch "active"
		else
			toggle.stateSwitch "default"
			toggleBkgd.stateSwitch "default"
			toggleBkgd.scale = 0
			toggleBkgd.animate
				scale: 1


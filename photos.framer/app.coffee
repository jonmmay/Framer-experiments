# Set up
bg = new BackgroundLayer

# Jonas Treub - Layer modulation
# Add a modulate function to Layer
Layer.prototype.modulate = (fraction, stateNameA, stateNameB, limit = true) ->
	
	if fraction is 0 or (limit and fraction < 0)
		this.states.switchInstant(stateNameA)
		return
	if fraction is 1 or (limit and fraction > 1)
		this.states.switchInstant(stateNameB)
		return
		
	stateA = _.clone(this.states[stateNameA])
	stateB = _.clone(this.states[stateNameB])
		
	newState = _.defaults stateB, stateA
	for property, valueA of stateA
		if _.has(stateB, property)
			valueB = stateB[property]
			if _.isNumber(valueA) and _.isNumber(valueB)
				newState[property] = Utils.modulate(fraction, [0, 1], [valueA, valueB], limit)
			if Color.isColor(valueA) and Color.isColor(valueB)
				newState[property] = Color.mix(valueA, valueB, fraction, limit)
		
	this.animateStop()
	this.props = newState
	
	# Jonmay - Rotation isn't being set by defining props.rotation
	# Set rotation property directly
	this.rotation = newState.rotation if this.rotation != newState.rotation

padding = 40
thumbWidth = 126
imageWidth = 750 * 2
imageHeight = Math.floor( ( 9 / 16 ) * imageWidth )

image = new Layer
	width: imageWidth
	height: imageHeight
	x: Align.center
	y: Align.center
	scale: 0.5
	visible: false

scrim = new Layer
	frame: Screen.frame
	backgroundColor: "#FFFFFF"
	opacity: 0
	visible: false

scrim.states.active =
	opacity: 1

scrim.animationOptions.curve = "spring(300,25,10)"

imageContainer = new Layer
	x: Align.center
	y: Align.center
	width: Screen.width - 40
	height: Screen.width - 40

imageCount = Math.floor( ( imageContainer.width - padding ) / ( thumbWidth + padding ) )
margin = imageContainer.width + padding - imageCount * ( thumbWidth + padding )
margin /= 2

for i in [ 0..imageCount - 1 ]
	imageThumb = new Layer
		parent: imageContainer
		x: margin + i * ( thumbWidth + padding )
		y: margin
		width: thumbWidth
		height: thumbWidth
		borderRadius: 8
		shadowY: 4
		shadowBlur: 8
		shadowColor: "rgba(0,0,0,0.3)"
		image: Utils.randomImage( image )
	
	imageThumb.on Events.TouchEnd, ( event, thumb ) ->
		thumb.visible = false

		currentImage = thumb.copy()		
		currentImage.props =
			screenFrame: thumb.screenFrame
			visible: true
			shadowColor: null
			originX: 0
			originY: 0

		currentImage.states.selected =
			width: Screen.width
			height: Math.floor( ( 9 / 16 ) * Screen.width )
			x: 0
			y: ( Screen.height - Math.floor( ( 9 / 16 ) * Screen.width ) ) / 2
			borderRadius: 0
				
		currentImage.pinchable.enabled = true
		currentImage.pinchable.maxScale = 2
		currentImage.draggable.enabled = true
		currentImage.draggable.momentumOptions =
			friction: 5
			tolerance: 0.1
		
		scrim.visible = true
		scrim.animate "active"
		scrim.bringToFront()
		currentImage.bringToFront()
		
		currentImage.animationOptions.curve = "spring(300,25,10)"
		currentImage.animate "selected"
		
		currentImage.on "change:scale", ( value, imageLayer ) ->
			if value < 1
				imageLayer.screenFrame.width = Utils.modulate( value, [ 1, 0 ], [ imageLayer.states.selected.width, imageLayer.states.default.width ], true )
				scrim.opacity = Utils.modulate( value, [ 1, 0 ], [ scrim.states.active.opacity, scrim.states.default.opacity ], true )

		currentImage.on Events.PinchEnd, ( event, imageLayer ) ->
			imageLayer.animate
				rotation: 0
			
			if imageLayer.scale < 1
				imageLayer.emit.apply( this, [ Events.DoubleTap ].concat Array.prototype.slice.call( arguments ) )

		currentImage.on Events.DragEnd, ( event, imageLayer ) ->
			if imageLayer.screenFrame.x > 0
				imageLayer.animate
					x: imageLayer.x - imageLayer.screenFrame.x
			else if imageLayer.screenFrame.x + imageLayer.screenFrame.width < Screen.width
				imageLayer.animate
					x: imageLayer.x - imageLayer.screenFrame.x - imageLayer.screenFrame.width + Screen.width
				
		# Close
		currentImage.on Events.DoubleTap, ( event, imageLayer ) ->
			imageLayer.animate "default",
				curve: "spring(300,28,10)"
			
			scrim.animate "default"
			
			imageLayer.on Events.AnimationEnd, ->
				thumb.visible = true
				scrim.visible = false
				imageLayer.destroy()

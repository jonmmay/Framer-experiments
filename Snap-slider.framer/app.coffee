# Set up
bg = new BackgroundLayer

LayerExtendedTouchEvents = require 'LayerExtendedTouchEvents'

# Helper functions
nearestValue = ( value, values ) ->
	for val, i in values
		if i == 0
			nearestVal = val
			valDiff = Math.abs( value - val )
		
		if Math.abs( value - val ) < valDiff
			nearestVal = val
			valDiff = Math.abs( value - val )
	
	return nearestVal

distributedValues = ( num ) ->
	values = [0]
	for i in [0...num]
		value = values[ i ] + 1 / num
		values.push value
	
	return values

sliderDistValues = distributedValues( 3 )

slider = new SliderComponent
	x: Align.center
	y: Align.center
	width: Screen.width - 40

# Detect touch start and end events
slider.on Events.TouchStart, ( event, layer ) ->
	layer.hasTouch = true

slider.on Events.TouchEnd, ( event, layer ) ->
	layer.hasTouch = false

# Trigger touchend event when touch ends outside of layer
window.addEventListener( "mouseup", ( e ) ->
	layers = Framer.CurrentContext.layers
	for layer in layers
		if layer.hasTouch
			layer.hasTouch = false
			layer.emit( Events.TouchEnd,  e, layer )
)

for value in sliderDistValues
	line = new Layer
		width: 2
		height: 40
		x: slider.x + ( value * slider.width )
		y: slider.y

slider.on Events.TouchEnd, ->
	value = slider.value
	slider.animateToValue( nearestValue( value, sliderDistValues )  )

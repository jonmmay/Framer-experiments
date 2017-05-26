# Extend layer to produce two events:
# 	touch up inside - trigger event when the touch event ends inside the layer's frame
# 	touch up outside - trigger event when the touch event ends outside the layer's frame

Events.TouchUpInside = "touchUpInside"
Events.TouchUpOutside = "touchUpOutside"

class LayerExtendedTouchEvents extends Layer
	constructor: ( @options={} ) ->
		@options._hasTouch ?= false
		super @options

		# set helper _hasTouch property on touch start and end events
		@on( Events.TouchStart, ->
			@options._hasTouch = true
		)
		@on( Events.TouchEnd, ( e, layer ) ->
			@options._hasTouch = false
			layer.emit( Events.TouchUpInside, e, layer )
		)

		doesWindowListenterExist = ->
			windowListeners = 0
			# Check if other layers are listening to window's mouseup events
			for layer in Framer.CurrentContext.layers
				if typeof layer._hasTouch != "undefined"
					windowListeners += 1

			if windowListeners <= 1
				return false
			else 
				return true

		windowListener = ( e ) ->
			layers = Framer.CurrentContext.layers
			for layer in layers
				if layer._hasTouch
					layer.emit( Events.TouchUpOutside, e, layer )

		# If a preexisting event listener doesn't exist, create one
		if doesWindowListenterExist() == false
			window.addEventListener( "mouseup", windowListener )

	@define "_hasTouch",
		get: ->
			return @options._hasTouch
		set: ( bool ) ->
			@options._hasTouch = bool

	# Helper Events
	onTouchUpInside: ( cb ) -> @on( Events.TouchUpInside, cb )
	onTouchUpOutside: ( cb ) -> @on( Events.TouchUpOutside, cb )

module.exports = LayerExtendedTouchEvents
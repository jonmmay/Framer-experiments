# Set up
bg = new BackgroundLayer

# Helpers
getRGBValuesFromColor = ( color ) ->
	arr = color.toRgbString().match( ///\d[^,|\)]*///g )
	arr = arr.map( ( val ) ->
		return val * 1	
	)
	return arr

# http://stackoverflow.com/questions/5650924/javascript-color-contraster
contrastingColor = ( r, g, b ) ->
	brightness = ( r * 299 ) + ( g * 587 ) + ( b * 114 )
	brightness = brightness / 255000;

	# values range from 0 to 1
	# anything greater than 0.5 should be bright enough for dark text
	return if brightness >= 0.5 then "#333333" else "#FFFFFF"

# Image
image = new Layer
	width: 600
	height: 800

image.image = Utils.randomImage( card )

# Card container
card = new Layer
	width: image.width
	height: image.height / 2
	x: Align.center
	y: Align.center
	backgroundColor: null
	animationOptions:
		curve: "spring(300,20,10)"

card.draggable.enabled = true
card.draggable.speedX = 0.1
card.draggable.constraints = card.frame
card.draggable.overdragScale = 0.25

cardInsideBottomFace = new Layer
	parent: card
	height: card.height
	width: card.width
	style:
		borderRadius: "0 0 20px 20px"
	clip: true

image.parent = cardInsideBottomFace
image.y = -image.height / 2

cardInsideBottomFace.states.up =
	shadowY: 10
	shadowBlur: 20
	shadowSpread: 4

# Card top container
cardTop = new Layer
	parent: card
	width: card.width
	height: card.height
	originY: 0
	backgroundColor: null
	
cardInsideTopFace = new Layer
	parent: cardTop
	width: card.width
	height: cardTop.height
	rotationX: 180
	z: -1
	style:
		borderRadius: "20px 20px 0 0"
	clip: true	

insideTopFaceImage = image.copy()
insideTopFaceImage.parent = cardInsideTopFace
insideTopFaceImage.y = 0

cardOutsideTopFace = new Layer
	parent: cardTop
	width: card.width
	height: cardTop.height
	backgroundColor: Color.random()
	clip: true
	style:
		borderRadius: "0 0 20px 20px"

# Card embellishments
gloss = new Layer
	parent: cardOutsideTopFace
	width: card.width * 2
	height: card.height * 0.75
	rotation: 6
	style:
		background: "-webkit-linear-gradient(top, rgba(255,255,255,0) 20%,rgba(255,255,255,0.3) 40%,rgba(255,255,255,0.3) 60%,rgba(255,255,255,0) 100%)"

gloss.y = -gloss.height * 2
gloss.x = card.x - gloss.width / 2

topShadow = new Layer
	parent: card
	width: card.width - 40
	height: card.height
	backgroundColor: null
	borderRadius: 20
	shadowY: 10
	shadowBlur: 20
	shadowSpread: 30
	shadowColor: "ccc"
	backgroundColor: "ccc"
	opacity: 0

topShadow.x = ( card.width - topShadow.width ) / 2
topShadow.states.up =
	opacity: 0.2

topShadow.sendToBack()

cardOutsideTopFace.bringToFront()

# Events
card.on Events.DragStart, ( event, layer ) ->
	cardTop.startRotX = cardTop.rotationX
	
	cardInsideBottomFace.animate "up"
	topShadow.animate "up"
	
card.on Events.DragEnd, ( event, layer ) ->
	cardInsideBottomFace.animate "default"
	topShadow.animate "default"
	
	if cardTop.rotationX > 100
		cardTop.animate
			rotationX: 180
			options:
				time: 0.3
	else
		cardTop.animate
			rotationX: 0
			options:
				time: 0.3
	
card.on Events.DragMove, ( event, layer ) ->
	offset = -event.offset.y
	swipeLength = 100
	minRotXInput = ( cardTop.startRotX / 180 ) * -swipeLength
	
	cardTop.rotationX = Utils.modulate( offset, [ minRotXInput, minRotXInput + swipeLength ], [ 0, 180 ], true )


cardTop.on "change:rotationX", ( value, layer ) ->	
	gloss.y = Utils.modulate( value, [ 10, 80 ], [ -gloss.height * 2, card.height * 2 ], true )
	gloss.height = Utils.modulate( value, [ 10, 80 ], [ card.height * 0.75, card.height * 2.5 ], true )
	
	topShadow.y = Utils.modulate( value, [ 60, 180 ], [ 0, -cardTop.height ], true )
	
	insideTopFaceImage.brightness = Utils.modulate( value, [ 120, 170 ], [ 60, 100 ], true )
	image.brightness = Utils.modulate( value, [ 0, 90 ], [ 60, 100 ], true )	

# Text
text = new TextLayer
	parent: cardOutsideTopFace
	text: "Swipe up"
	textAlign: "center"
	x: Align.center
	y: Align.center
	color: contrastingColor.apply( null, getRGBValuesFromColor( new Color( cardOutsideTopFace.backgroundColor ) ) )
options =
	scale: 1.2

bgImage = new Layer
	parent: lockScreenPage
	width: 750
	height: 1334
	image: "images/Home Wallpaper - Raster Image.png"
	scale: options.scale

pager = new PageComponent
	width: Screen.width
	height: Screen.height
	backgroundColor: null

pager.scrollVertical = false
pager.content.clip = false

# Unlock page
unlockPage = new Layer
	x: Screen.width
	width: Screen.width
	height: Screen.height
	backgroundColor: null

prettyTime = ( time ) ->
	date = new Date( parseInt( time ) )
	localeSpecificTime = date.toLocaleTimeString()
	localeSpecificTime = localeSpecificTime.replace( ///^(\d+:\d+):\d+\ \w+$///, "$1" )
	return localeSpecificTime

prettyDate = ( time ) ->
	date = new Date( parseInt( time ) )
	localeSpecificDate = date.toLocaleDateString( "en-US", { month: "short", day: "numeric", weekday: "long" } )
	return localeSpecificDate

timeLabel = new TextLayer
	parent: unlockPage
	y: 110
	width: Screen.width
	color: "#FFFFFF"
	textAlign: "center"
	fontSize: 170
	fontWeight: 200
	text: prettyTime Date.now()

dateLabel = new TextLayer
	parent: unlockPage
	y: 304
	width: Screen.width
	color: "#FFFFFF"
	textAlign: "center"
	fontSize: 35
	fontWeight: 360
	text: prettyDate Date.now()

camera = new Layer
	parent: unlockPage
	x: Align.right
	y: Align.bottom
	width: 86
	height: 91
	image: "images/camera.png"

Utils.interval 10, ->
    timeLabel.text = prettyTime Date.now()
    dateLabel.text = prettyDate Date.now()

# Lock page
lockScreenPage = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: null

pager.addPage( lockScreenPage )
pager.addPage( unlockPage )

pager.snapToPage( unlockPage, false )

bgImageBlur = new Layer
	parent: lockScreenPage
	frame: Screen.frame
	image: bgImage.image
	blur: 0
	opacity: 0
# 	style:
# 		"mix-blend-mode": "overlay"
# 		"-webkit-backdrop-filter": "blur(50px)"
# 		"background-color": "rgba(0,0,0,0.5)"

bgImageDarkOverlay = new Layer
	parent: lockScreenPage
	frame: Screen.frame
	backgroundColor: "rgba(0,0,0,0)"
# 	style:
# 		"mix-blend-mode": "darken"

numPadBlur = new Layer
	parent: lockScreenPage
	frame: Screen.frame
	opacity: 1
	blur: 10
	image: bgImage.image
	style:
		"-webkit-mask": "url(images/numCircles.png)"
		"background-position": "center"

numPadDarkOverlay = new Layer
	parent: lockScreenPage
	frame: Screen.frame
	backgroundColor: "rgba(0,0,0,0.0)"
	style:
		"mix-blend-mode": "overlay"
		"background-image": "url(images/numCircles.png)"

# new Layer
# 	parent: lockScreenPage
# 	frame: Screen.frame
# 	backgroundColor: null
# 	style:
# 		"background-image": "url(images/numCircles.png)"
# 		"mix-blend-mode": "overlay"

lockScreenText = new Layer
	parent: lockScreenPage
	width: 750
	height: 1334
	image: "images/lockScreenText.png"

statusBar = new Layer
	width: Screen.width
	height: 40
	image: "images/status.png"

handle = new Layer
	x: Align.center
	y: Align.bottom
	width: 104
	height: 76
	image: "images/piddle.png"

pager.on Events.Move, ( event, layer ) ->
	value = layer.x
	range = [ -Screen.width, 0 ]
	
	bgImage.scale = Utils.modulate( value, range, [ options.scale, 1 ], true )
	
	bgImageBlur.x = -value
	
	bgImageBlur.opacity = Utils.modulate( value, range, [ 0, 1 ], true )
	bgImageBlur.blur = Utils.modulate( value, range, [ 0, 50 ], true )

# 	Doesn't work on mobile
# 	bgImageBlur.style[ "background-color" ] = "rgba(0,0,0," +  Utils.modulate( value, range, [ 0, 0.5 ], true ) + ")"
# 	bgImageBlur.style[ "-webkit-backdrop-filter" ] = "blur(" + Utils.modulate( value, range, [ 0, 50 ], true ) + "px)"

	bgImageDarkOverlay.x = -value
	
	bgImageDarkOverlay.backgroundColor = "rgba(0,0,0," +  Utils.modulate( value, range, [ 0, 0.3 ], true ) + ")"

	numPadDarkOverlay.x = -value
	
	numPadDarkOverlay.backgroundColor = "rgba(0,0,0," +  Utils.modulate( value, range, [ 0, 0.5 ], true ) + ")"
	
	numPadDarkOverlay.style[ "background-position" ] = "#{value}px 0"
	
	numPadBlur.style[ "background-position" ] = "#{-value}px 0"
	numPadBlur.style[ "background-size" ] = Utils.modulate( value, range, [ options.scale, 1 ], true ) * 100 + "%"
	
	handle.y = Utils.modulate( value, range, [ Screen.height - handle.height, Screen.height ], true )
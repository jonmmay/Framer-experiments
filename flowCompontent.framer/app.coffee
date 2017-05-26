# Set up
bg = new BackgroundLayer

centerInParent = ( axis, child, parent ) ->
	dim = if axis == "x" then "width" else if axis == "y" then "height"
	
	return if dim then ( parent[ dim ] - child[ dim ] ) / 2 else 0

# Header container
header = new Layer
	width: Screen.width
	height: 128

# Status bar
statusBar = new Layer
	parent: header
	width: Screen.width
	height: 40

statusBarText = new TextLayer
	parent: statusBar
	x: Align.center
	text: "9:46 AM"
	textAlign: "center"
	fontSize: 26
	fontStyle: "bold"

statusBarText.y = centerInParent( "y", statusBarText, statusBar )

# Nav bar
navBar = new Layer
	parent: header
	width: Screen.width
	height: 88
	y: 40
	style:
		borderWidth: "0 0 2px 0"

navBarBackButton = new Layer
	parent: navBar
	html: "<?xml version=\"1.0\" ?><!DOCTYPE svg  PUBLIC '-//W3C//DTD SVG 1.1//EN'  'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'><svg enable-background=\"new 0 0 50 50\" height=\"50px\" id=\"Layer_1\" version=\"1.1\" viewBox=\"0 0 50 50\" width=\"50px\" xml:space=\"preserve\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\"><rect fill=\"none\" height=\"50\" width=\"50\"/><polygon fill=\"#007aff\" points=\"35,47.25 37.086,45.164 16.922,25 37.086,4.836 35,2.75 12.75,25 \"/><rect fill=\"none\" height=\"50\" width=\"50\"/></svg>"
	height: 50
	width: 50
	backgroundColor: null
	visible: false

navBarBackButton.y = centerInParent( "y", navBarBackButton, navBar )

navBarBackButton.states.visible =
	visible: true

screenA = new Layer
	width: Screen.width
	height: Screen.height - navBar.maxY
	directionLock: true

imageA = new Layer
	parent: screenA
	width: Screen.width
	height: Screen.height - navBar.maxY

imageA.image = Utils.randomImage( imageA )

screenB = new Layer
	width: Screen.width
	height: Screen.height - 128
	directionLock: true

imageB = new Layer
	parent: screenB
	width: Screen.width
	height: Screen.height - navBar.maxY

imageB.image = Utils.randomImage( imageB )

storyboardFlow = new FlowComponent
	size: Screen.size

storyboardFlow.header = header
storyboardFlow.showNext( screenA )

screenA.on Events.SwipeLeft, ->
	storyboardFlow.showNext( screenB )
	navBarBackButton.stateSwitch( "visible" )

screenB.on Events.SwipeLeft, ->
	storyboardFlow.showNext( screenA )
	navBarBackButton.stateSwitch( "visible" )
	
navBarBackButton.on Events.TouchEnd, ->
	storyboardFlow.showPrevious()
	
	if  not storyboardFlow.previous
		navBarBackButton.stateSwitch( "default" )
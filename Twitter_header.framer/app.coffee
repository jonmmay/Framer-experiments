# Set up
bg = new BackgroundLayer

# Global variables
headerHeight = 250
headerMinHeight = 128
avatarYPos = 195
avatarMinWidth = 86
blurMargin = 20
statusBarOffset = 40


scroll = new ScrollComponent
	y: headerMinHeight
	width: Screen.width
	height: Screen.height - headerMinHeight
	scrollHorizontal: false
	backgroundColor: "#E6ECF0"
	contentInset:
		top: headerHeight - headerMinHeight

header = new Layer
	width: Screen.width
	height: headerHeight
	clip: true

headerImage = header.copy()
headerImage.props =
	parent: header
	x: header.x - blurMargin
	y: header.y - blurMargin
	width: header.width + blurMargin * 2
	height: header.height + blurMargin * 2
	image: Utils.randomImage()

headerText = new Layer
	parent: header
	width: Screen.width
	y: headerMinHeight * 2
	backgroundColor: null

headerTitle = new TextLayer
	parent: headerText
	width: Screen.width
	text: "Jonathan May"
	color: "#FFFFFF"
	textAlign: "center"
	fontSize: 35

headerSubtitle = headerTitle.copy()
headerSubtitle.props =
	parent: headerText
	text: "6 Tweets"
	y: headerTitle.height
	fontSize: 25

headerText.height = headerTitle.height + headerSubtitle.height

avatar = new Layer
	x: 16
	y: avatarYPos
	width: 152
	height: 152
	borderWidth: 8
	borderRadius: 16
	borderColor: "#FFFFFF"
	image: Utils.randomImage()

header.on "change:height", ( value, layer ) ->
	headerImage.height = layer.height + blurMargin * 2


scroll.content.on Events.Move, ( event, layer ) ->
	offsetFromZero = scroll.content.screenFrame.y
	offsetFromInset = event.y
	offset = event.y - scroll.contentInset.top	
	
	# avatar maxY with scale
	avatarOffset = avatarYPos + offset + ( avatar.height - avatar.height * avatar.scale ) / 2
	avatarScale = avatarMinWidth / ( avatar.width - avatar.borderWidth * 2 )

	# Show reduced header
	if offsetFromInset < 0
		header.height = headerMinHeight
		# Avatar should scroll with content
		avatar.y = avatarOffset
		header.bringToFront()
	
	# Overscrolling
	else if offsetFromZero > headerHeight
		# Grow header with scroll
		header.height = offsetFromZero
		# Keep avatar in tow with header height
		avatar.y = header.height - ( headerHeight - avatarYPos )
		
		avatar.bringToFront()
	
	# Procedural animation with scroll
	else
		# Shrink header with scroll
		header.height = offsetFromZero
		
		avatar.bringToFront()
		header.placeBehind( avatar )
	
	# Scale and position avatar
	avatar.scale = Utils.modulate -offset, [ 0, scroll.contentInset.top ], [1, avatarScale], true
	avatar.y = avatarOffset
	
	# Blur
	# Procedural animation with scroll
	if offsetFromInset <= avatarMinWidth
		headerImage.blur = Utils.modulate -offsetFromInset, [ avatarMinWidth, avatarMinWidth + 16 ], [ 0, 12 ], true	
	
	# Show unblurred header
	else
		headerImage.blur = 0
	
	# Header text
	headerText.y = Utils.modulate( 
		offsetFromZero, 
		[ 0, ( headerMinHeight - headerText.height + statusBarOffset ) / 2 - headerMinHeight ],
		[ headerMinHeight, ( headerMinHeight - headerText.height + statusBarOffset ) / 2 ],
		true )
	
	headerText.visible = if headerText.y < headerMinHeight then true else false


# 
# new Layer
# 	parent: scroll.content
# 	height: Screen.height * 2
# 	width: Screen.width
# 	style:
# 		background: "-webkit-linear-gradient(top, #FFFFFF 0%, #28AFFA 100%)"
		
twitterFeed = new Layer
	parent: scroll.content
	width: 750
	height: 5005
	image: "images/twitter feed.png"

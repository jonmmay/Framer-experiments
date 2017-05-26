# Set up
bg = new BackgroundLayer

cardHeight = 300
headers = []

scroll = new ScrollComponent
	height: Screen.height
	width: Screen.width
	scrollHorizontal: false
	contentInset:
		bottom: 40
		top: 40

text = new TextLayer
	parent: scroll.content
	width: scroll.width
	text: "Scroll ↑"
	textAlign: "center"

for i in [0..20]
	card = new Layer
		parent: scroll.content
		width: scroll.width
		height: cardHeight
		y: 100 + i * ( cardHeight + 40 )
		backgroundColor: "bada55"
		hueRotate: 10 * ( i + 1 )
	
	header = card.copy()
	header.parent = scroll.content
	header.height = 100
	header.hueRotate = 360 - header.hueRotate
	header.backgroundColor = new Color( header.backgroundColor ).saturate( 100 )
	
	header.stickyY = header.y
	
	headers.push header
	
	headerText = new TextLayer
		parent: header
		text: if i < 10 then "oooh" else "aaah"
		width: header.width
		x: 20
		color: "fff"
	
	headerText.y = ( header.height - headerText.height ) / 2

scroll.content.on "change:y", ( offset ) ->
	if offset <= 15
		text.text = "Scroll 👍"
	else
		text.text = "Scroll ↑"
	
	offset = -offset
	
	for header in headers
		maxHeaderPosInCard = header.stickyY + ( cardHeight - header.height )
		
		if offset > header.stickyY
			# Don't exceed card height
			if offset > maxHeaderPosInCard
				header.y = maxHeaderPosInCard
			
			# Stick to top, aka scroll offset
			else
				header.y = offset
		
		# return header to original position
		else 
			header.y = header.stickyY
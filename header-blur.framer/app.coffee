# Set up
bg = new BackgroundLayer

pager = new PageComponent
	x: 60
	y: 60
	width: Screen.width - 120
	height: Screen.height - 120
	backgroundColor: null
	scrollVertical: false
	clip: false

header = new Layer
	width: Screen.width
	height: 128
	shadowY: 1
	shadowColor: "rgba(0,0,0,0.3)"
	shadowBlur: 0
	backgroundColor: "rgba(246,246,246,0.7)"
	style:
		"mix-blend-mode": "luminosity"
		"-webkit-backdrop-filter": "blur(40px)"

statusBar = new Layer
	width: 725
	height: 20
	image: "images/Status Bar - 100%  Battery Charging - Dark.png"

statusBar.x = (Screen.width - statusBar.width) / 2
statusBar.y = (40 - statusBar.height) / 2

for i in [0..3]	
	new Layer
		parent: pager.content
		size: pager.size
		x: (Screen.width + 60) * i
		image: Utils.randomImage()
# Set up
bg = new BackgroundLayer

x = Screen.midX
y = Screen.midY
dist = 200

container = new Layer
	frame: Screen.frame
	backgroundColor: null
	z: 400
	rotationX: 60

mid = new Layer
	parent: container
	x: x - 5
	y: y - 5
	width: 10
	height: 10
	borderRadius: "100%"

container.animate
	rotationZ: 360
	options:
		curve: "linear"
		time: 60

container.on Events.AnimationEnd, ->
	container.rotationZ = 0
	container.animate
		rotationZ: 360
		options:
			curve: "linear"
			time: 60

for i in [0..11]
	deg = 30
	rad = i * deg * Math.PI / 180
	width = 100
	
	layer = new Layer
		parent: container
		x: dist * Math.cos( rad ) + x - width / 2
		y: dist * Math.sin( rad ) + y - width / 2
		width: width
		height: width
		rotationX: 90
		backgroundColor: "#BADA55"
		hueRotate: i * deg
		borderRadius: "100%"
		opacity: 0.7
	
	layer.animate
		rotationY: 360
		options:
			curve: "linear"
			time: 10
	
	layer.on Events.AnimationEnd, ->
		@.rotationY = 0
		@.animate
			rotationY: 360
			options:
				curve: "linear"
				time: 10
# set up
bg = new BackgroundLayer

card = new Layer
	width: 480
	height: 720
	x: Align.center
	y: Align.center
	z: 200
	# Color
	backgroundColor: Color.random()
	style: borderRadius: "24px"
	# Shadow
	shadowBlur: 0
	shadowY: 0
	shadowX: 0
	shadowSpread: 0

card.shadowColor = new Color( card.backgroundColor ).darken( 10 ).alpha( 0.22 )

card.draggable.enabled = true
card.draggable.constraints =
	x: ( Screen.width - card.width ) / 2
	y: ( Screen.height - card.height ) / 2
	width: card.width
	height: card.height

card.draggable.overdragScale = 0.2

card.states.animationOptions =
	curve: "spring(300,20,10)"

card.states.zoom =
	scale: 1.05
	shadowBlur: 20

card.on Events.DragStart, ( event, layer ) ->
	layer.dragStartX = layer.x
	layer.dragStartY = layer.y
	
	layer.animate "zoom"

card.on Events.DragMove, ( event, layer ) ->	
	velocity = layer.draggable.calculateVelocity()
	cardRotationY = Utils.modulate velocity.x, [5,-5], [-50,50], true
	cardRotationX = Utils.modulate -velocity.y, [5,-5], [-50,50], true
	
	card.shadowY = ( layer.y - layer.dragStartY ) * -0.3
	card.shadowX = ( layer.x - layer.dragStartX ) * -0.3
	
# 	layer.animate "zoom"
	
	layer.animate
		rotationY: cardRotationY
		rotationX: cardRotationX

card.on Events.DragEnd, ( event, layer ) ->
	layer.animate "default"
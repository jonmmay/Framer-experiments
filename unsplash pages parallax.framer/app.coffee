# Set up

ajax = (url, callback) ->
    request = new XMLHttpRequest()
    request.open('GET', url, true)

    request.onload = ->
        if request.status >= 200 and request.status < 400
            callback(JSON.parse(request.responseText))
        else
            callback(JSON.parse({status: false}))

    request.onerror = ->
        callback(JSON.parse({status: false}))

    request.send()

bg = new BackgroundLayer

# Unsplash

getUnsplashImage = ( callback ) ->
	ajax( "https://api.unsplash.com/photos/random/?client_id=c7b50ab40aed2a50abb0510a62859fb93eb62b64849a1e40776fac8a099f8524", callback )
	
pager = new PageComponent
	width: Screen.width - 160
	height: (Screen.width - 160)*.75
	scrollVertical: false
	clip: false

pager.center()

calcPos = ( page, image ) ->
	image.x = Utils.modulate( page.screenFrame.x, [ page.width, -page.width ], [ -200, 0 ] )

makeCards = ->
	images = [
		"https://images.unsplash.com/photo-1490735032890-1e13a3e0e00c?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=1afd0b76ab8d773b6f9ad231cb7f0835",
		"https://images.unsplash.com/photo-1462826971377-c033341482bb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=8cfda48b4657958c10318f3e24f5341b",
		"https://images.unsplash.com/reserve/fawrXCzwSsOUMmJr9GGD_alcatraz.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=266e7e2fb87ac8cc7c6ee4dda212e2b9",
		"https://images.unsplash.com/photo-1490138085483-1aa5dba23f14?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=7c9507db717d419cb811052cca52bb31"
	]
	
	for image, i in images
		card = new Layer
			parent: pager.content
			width: Screen.width - 160
			height: pager.height
			x: Screen.width * i
			clip: true
		
		cardImage = new Layer
			parent: card
			x: -200
			width: card.width + 200
			height: card.height
			image: image
		
		calcPos( card, cardImage )

makeCards()

# Events
pager.onMove ->
	for card in pager.content.children
		calcPos( card, card.children[ 0 ] )
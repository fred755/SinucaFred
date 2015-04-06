local physics = require("physics")

physics.start()

--physics.setDrawMode("hybrid")
physics.setScale( 60 )
physics.setGravity( 0, 0 )

local propriedadeBola = { density=1, radius=15 }


function criarNovoJogo()
	
	componentesBordas = display.newGroup()
	
	local mesa = display.newImage( "table1.png", true)
	componentesBordas:insert(mesa)
	mesa.x = 384
	mesa.y = 512
	
	local bumpers = { friction=0.5, bounce=0.5 }

	local bumper1 = display.newImage( "bumper_cima.png" )
	componentesBordas:insert(bumper1)
	physics.addBody( bumper1, "static", bumpers )
	bumper1.x = 384; bumper1.y = -110

	local bumper2 = display.newImage( "bumper_cima.png" )
	componentesBordas:insert(bumper2)
	physics.addBody( bumper2, "static", bumpers )
	bumper2.x = 384; bumper2.y = 1135; bumper2.rotation = 180

	local bumper3 = display.newImage( "bumper_lados.png" )
	componentesBordas:insert(bumper3)
	physics.addBody( bumper3, "static", bumpers )
	bumper3.x = 70; bumper3.y = 195

	local bumper4 = display.newImage( "bumper_lados.png" )
	componentesBordas:insert(bumper4)
	physics.addBody( bumper4, "static", bumpers)
	bumper4.x = 700; bumper4.y = 195; bumper4.rotation = 180

	local bumper5 = display.newImage( "bumper_lados.png" )
	componentesBordas:insert(bumper5)
	physics.addBody( bumper5, "static", bumpers )
	bumper5.x = 70; bumper5.y = 830

	local bumper6 = display.newImage( "bumper_lados.png" )
	componentesBordas:insert(bumper6)
	physics.addBody( bumper6, "static", bumpers )
	bumper6.x = 700; bumper6.y = 830; bumper6.rotation = 180

 	incluirBolas()
end

function incluirBolas()
	
	bolasJogo = display.newGroup()
	
	bolaBranca = display.newImage( "ball_white.png" )
	bolasJogo:insert(bolaBranca)
	physics.addBody( bolaBranca, propriedadeBola )
	bolaBranca.x = display.contentWidth/2;
	bolaBranca.y = 950
	bolaBranca.linearDamping = 0.3
	bolaBranca.angularDamping = 0.8
	bolaBranca.type = "bolaBranca"
	bolaBranca.collision = onCollision
	bolaBranca:addEventListener("collision", bolaBranca)
	bolaBranca:addEventListener( "postCollision", bolaBranca )
	

	local bolaVermelha = {}

		bolaVermelha1 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha1)
		physics.addBody(bolaVermelha1, propriedadeBola)
		bolaVermelha1.x = 318
		bolaVermelha1.y = 90
		bolaVermelha1.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha1.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha1.type = "bolaBranca"
		bolaVermelha1.collision = onCollision
		bolaVermelha1:addEventListener("collision", bolaVermelha1)
		bolaVermelha1:addEventListener( "postCollision", bolaVermelha1 )

		bolaVermelha1:addEventListener( "touch", baterBola )

		bolaVermelha2 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha2)
		physics.addBody(bolaVermelha2, propriedadeBola)
		bolaVermelha2.x = 352
		bolaVermelha2.y = 90
		bolaVermelha2.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha2.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha2:addEventListener( "postCollision", bolaVermelha2 )

		bolaVermelha3 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha3)
		physics.addBody(bolaVermelha3, propriedadeBola)
		bolaVermelha3.x = 386 
		bolaVermelha3.y = 90
		bolaVermelha3.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha3.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha3:addEventListener( "postCollision", bolaVermelha3 )

		bolaBranca:addEventListener( "touch", baterBola )
		criarBuracos()

		bolaVermelha4 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha4)
		physics.addBody(bolaVermelha4, propriedadeBola)
		bolaVermelha4.x = 420 
		bolaVermelha4.y = 90
		bolaVermelha4.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha4.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha4:addEventListener( "postCollision", bolaVermelha4 )

		bolaBranca:addEventListener( "touch", baterBola )
		criarBuracos()

		bolaVermelha4 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha4)
		physics.addBody(bolaVermelha4, propriedadeBola)
		bolaVermelha4.x = 454 
		bolaVermelha4.y = 90
		bolaVermelha4.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha4.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha4:addEventListener( "postCollision", bolaVermelha4 )

		bolaBranca:addEventListener( "touch", baterBola )
		criarBuracos()
	
end


function resetbolaBranca()
	bolaBranca.alpha = 0
	bolaBranca.x = 384
	bolaBranca.y = 780
	bolaBranca.xScale = 2.0; bolaBranca.yScale = 2.0
	local dropBall = transition.to( bolaBranca, { alpha=1.0, xScale=1.0, yScale=1.0, time=400 } )
end


function colisaoBuraco( self, event )

	local caiu = transition.to( event.other, { alpha=0, xScale=0.3, yScale=0.3, time=200 } )
	local object = event.other
	
	event.other:setLinearVelocity( 0, 0 )
		
	if event.other.type == "bolaBranca" then
		timer.performWithDelay( 50, resetbolaBranca )
	end

end


function criarBuracos()

	local buraco = {}

			local sensorRadius = 20
			buraco1 = display.newCircle( 67, -112, sensorRadius )
			componentesBordas:insert(buraco1)
			
			buraco1.isVisible = true
			physics.addBody( buraco1, { radius=sensorRadius, isSensor=true } )
			buraco1.id = "buraco"
			buraco1.bullet = false
			buraco1.collision = colisaoBuraco
			buraco1:addEventListener( "collision", buraco1 )

			buraco2 = display.newCircle( 702, -112, sensorRadius )
			componentesBordas:insert(buraco2)
			
			buraco2.isVisible = true
			physics.addBody( buraco2, { radius=sensorRadius, isSensor=true } )
			buraco2.id = "buraco"
			buraco2.bullet = false
			buraco2.collision = colisaoBuraco
			buraco2:addEventListener( "collision", buraco2 )


			buraco3 = display.newCircle( 67, 510, sensorRadius )
			componentesBordas:insert(buraco3)

			buraco3.isVisible = true
			physics.addBody( buraco3, { radius=sensorRadius, isSensor=true } )
			buraco3.id = "buraco"
			buraco3.bullet = false
			buraco3.collision = colisaoBuraco
			buraco3:addEventListener( "collision", buraco3 )

			buraco4 = display.newCircle( 702, 510, sensorRadius )
			componentesBordas:insert(buraco4)


			buraco4.isVisible = true
			physics.addBody( buraco4, { radius=sensorRadius, isSensor=true } )
			buraco4.id = "buraco"
			buraco4.bullet = false
			buraco4.collision = colisaoBuraco
			buraco4:addEventListener( "collision", buraco4 )

			buraco5 = display.newCircle( 67, 1130, sensorRadius )
			componentesBordas:insert(buraco5)

			buraco5.isVisible = true
			physics.addBody( buraco5, { radius=sensorRadius, isSensor=true } )
			buraco5.id = "buraco"
			buraco5.bullet = false
			buraco5.collision = colisaoBuraco
			buraco5:addEventListener( "collision", buraco5 )

			buraco6 = display.newCircle( 702, 1130, sensorRadius )
			componentesBordas:insert(buraco6)

			buraco6.isVisible = true
			physics.addBody( buraco6, { radius=sensorRadius, isSensor=true } )
			buraco6.id = "buraco"
			buraco6.bullet = false
			buraco6.collision = colisaoBuraco
			buraco6:addEventListener( "collision", buraco6 )
end

function baterBola( event )

	local t = event.target
	t:applyForce( (t.x - event.x), (t.y - event.y), t.x, t.y )	

end

criarNovoJogo()
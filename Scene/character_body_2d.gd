extends CharacterBody2D

const SPEED = 300

#func _physics_process(_delta: float) -> void:
#	var direction = 1
#	velocity.x = direction * SPEEDdwa

#	move_and_slide()

func _process(delta):
	var direction = Vector2.ZERO # Vector de moviment del jugador.
	
	if Input.is_action_pressed("mover_derecha"):
		direction.x += 1
	if Input.is_action_pressed("mover_izquierda"):
		direction.x -= 1
	if Input.is_action_pressed("mover_abajo"):
		direction.y += 1
	if Input.is_action_pressed("mover_arriba"):
		direction.y -= 1
	
	if direction.length() > 0:
		direction = direction.normalized() * SPEED
		$Heroe.play()
	else:
		$Heroe.stop()

	if direction.x != 0:
		$Heroe.animation = "default"
		$Heroe.flip_v = false
		$Heroe.flip_h = direction.x < 0
	elif direction.y != 0:
		if direction.y > 0:
			$Heroe.animation = "defaultAbajo"
		elif direction.y < 0:
			$Heroe.animation = "defaultArriba"

	velocity = direction
	move_and_slide()

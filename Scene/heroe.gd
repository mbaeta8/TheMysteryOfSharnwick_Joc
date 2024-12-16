extends CharacterBody2D

const SPEED = 300
var house = null 

func set_house(new_house):
	house = new_house

func _ready():
	player.position = Global.player_position

func _unhandled_input(event):
	if event is InputEventKey and event.is_action_pressed("interaction") and house != null:
		Global.player_position = position
		house.enter()

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

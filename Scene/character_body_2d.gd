extends CharacterBody2D

const SPEED = 300

#func _physics_process(_delta: float) -> void:
#	var direction = 1
#	velocity.x = direction * SPEED

#	move_and_slide()

var house = null 

func set_house(new_house):
	house = new_house

func _ready():
	if Global.player_position != Vector2.ZERO:
		$Player.position = Global.player_position
	else:
		$Player.position = Vector2(500,450)

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
		$Player.play()
	else:
		$Player.stop()

	if direction.x != 0:
		$Player.animation = "default"
		$Player.flip_v = false
		$Player.flip_h = direction.x < 0
	elif direction.y != 0:
		if direction.y > 0:
			$Player.animation = "defaultAbajo"
		elif direction.y < 0:
			$Player.animation = "defaultArriba"

	velocity = direction
	move_and_slide()

extends CharacterBody2D


const SPEED = 100.0


func _physics_process(_delta: float) -> void:
	
	var direction = 1
	velocity.x = direction * SPEED

	move_and_slide()

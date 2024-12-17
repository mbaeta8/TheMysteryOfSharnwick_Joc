extends Node2D

var entered = false
var is_exiting = false


func _ready():
	entered = false

func _on_exit_body_entered(body):
	if body.name == "Player":
		entered = true

func _on_exit_body_exited(body):
	if body.name == "Player":
		entered = false

func _process(delta):
	if entered and Input.is_action_just_pressed("interaction"):
		Global.player_position = Global.pos_puerta
		get_tree().change_scene_to_file("res://Scene/VideoWebProv.tscn")
		Global.has_left_house = true

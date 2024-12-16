extends Node2D

@export var inside_house:PackedScene

func _on_door_way_body_entered(body):
	body.house = self

func _on_door_way_body_exited(body):
	if body.house == self:
		body.house = null

func enter():
	get_tree().change_scene_to_file("res://Scene/inside.tscn")

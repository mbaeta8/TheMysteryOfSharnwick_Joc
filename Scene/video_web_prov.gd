extends Node2D

var fin_demo: PackedScene = preload("res://Scene/control.tscn")

var fin_instance = Control

func _ready():
	var player = $Player
	#player.position = Global.player_position
	
	#if Global.has_left_house:
	#	Global.has_left_house = false
	#	fin_instance = fin_demo.instantiate()
	#	add_child(fin_instance)

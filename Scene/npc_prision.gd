extends CharacterBody2D

var player
var player_in_chat_zone = false
var is_chatting = false
var is_current_npc = false

func _on_chat_body_entered(body):
	player_in_chat_zone = true
		
func _on_chat_body_exited(body):
	player_in_chat_zone = false
	is_chatting = false

func _process(delta):
	if Input.is_action_just_pressed("chat") and player_in_chat_zone and not is_chatting:
		#DialogueManager.show_example_dialogue_balloon(load("res://Dialogos/GuardiaPrision.dialogue"), "start")
		is_chatting = true
		$AnimatedSprite2D.play("idle_guardia")

extends CharacterBody2D

var isKilleable = false
var actualHp = 1

func _ready():
	pass

func _on_mouse_entered() -> void:
	$"../descripcionesEfectos".text = "Goblin Brujo\n\n[color=#000000]Resistencias:[/color]\n[color=#ee2d27]Fuego: 100%[/color]\n[color=#c71ef5]Mágia: 100%[/color]\n[color=#1195e0]Hielo: 100%[/color]"

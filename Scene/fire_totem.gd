extends CharacterBody2D

var actualHp = 12

func _ready():
	$AnimatedSprite2D.play("idle")

func _on_mouse_entered() -> void:
	$"../descripcionesEfectos".text = "Totem de fuego de Goblin Brujo\n\n[color=#000000]Resistencias:[/color]\n[color=#ee2d27]Fuego: 100%[/color]\n[color=#c71ef5]Mágia: 50%[/color]\n[color=#1195e0]Hielo: 0%[/color]"

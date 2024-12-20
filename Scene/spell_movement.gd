extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var especificacionesMovementSpell = "[color=#38de33]Alcance: 10 Metros[/color]\n[color=#009df0]Coste: 3 Acciones[/color]\n[color=#f58f14]Recarga: 2 Turnos[/color]\n\n"

func _on_mouse_entered() -> void:
	$"../descripcionesEfectos".text = especificacionesMovementSpell + "Otorga [color=#c9ff00][b]+100[/b] puntos de movimiento[/color]"

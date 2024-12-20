extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var especificacionesInstaKillSpell = "[color=#38de33]Alcance: 100 Metros[/color]\n[color=#009df0]Coste: 5 Acciones[/color]\n\n"

func _on_mouse_entered() -> void:
	$"../descripcionesEfectos".text = especificacionesInstaKillSpell + "[color=#c80c64]Elimina al objetivo[/color] en caso de [color=#129494] no tener ninguna invocación activa[/color]"

extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var especificacionesIceSpell = "[color=#38de33]Alcance: 20 Metros[/color]\n[color=#009df0]Coste: 2 Acciones[/color]\n\n"

func _on_mouse_entered() -> void:
	$"../descripcionesEfectos".text = especificacionesIceSpell + "Inflige [color=#1195e0][b]2 a 5[/b] puntos de daño de hielo[/color] al objetivo"

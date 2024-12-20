extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame. 
func _process(delta: float) -> void:
	
	pass

var especificacionesHealSpell = "[color=#38de33]Alcance: 2 Metros[/color]\n[color=#009df0]Coste: 3 Acciones[/color]\n[color=#f58f14]Recarga: 3 Turnos[/color]\n\n"

func _on_mouse_entered() -> void:
	$"../descripcionesEfectos".text = especificacionesHealSpell + "Sana al objetivo [color=#278c1d][b]1 a 3[/b] punto de salud[/color]"
	

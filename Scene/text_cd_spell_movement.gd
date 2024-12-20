extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".hide()
	$"../CITmovement".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	$"../descripcionesEfectos".text = "Otorga [color=#c9ff00][b]+100[/b] puntos de movimiento[/color]"

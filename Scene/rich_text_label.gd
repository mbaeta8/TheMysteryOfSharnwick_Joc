extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".hide()
	$"../CITheal".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_mouse_entered() -> void:
	$"../descripcionesEfectos".text = "Sana al objetivo [color=#f3e628][b]1[/b] punto de salud[/color]"

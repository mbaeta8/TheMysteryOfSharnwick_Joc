extends Button
@onready var button = $Button

signal finTurno

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	emit_signal("finTurno")

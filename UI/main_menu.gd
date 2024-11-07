extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_settings_pressed() -> void:
	#$StartMenu.visible = false
	#$ContinueMenu.visible = true
	#get_tree().root.content_scale_factor = 0.5
	get_tree().root.size.x = 960
	get_tree().root.size.y = 540

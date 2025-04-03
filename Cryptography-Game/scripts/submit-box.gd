extends Control
signal submit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("open-window")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	submit.emit();


func _on_text_edit_text_changed() -> void:
	GlobalSounds.click.play()


func _on_texture_button_mouse_entered() -> void:
	GlobalSounds.hover.play()

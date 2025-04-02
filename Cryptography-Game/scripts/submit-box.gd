extends Control
signal submit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("open-window")


func _on_texture_button_pressed() -> void:
	submit.emit();

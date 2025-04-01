extends Container
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_level_load_level(level: PackedScene, anim: String) -> void:
	if level == null:
		print("Level was null");
		return;
	Global.game_scene._load_new_level(level, anim);
	queue_free();

func _on_close_button_pressed() -> void:
	GlobalSounds.close.play()
	queue_free();


func _on_close_button_mouse_entered() -> void:
	GlobalSounds.hover.play()

extends Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("open-window")
	if Global.caesarComplete == false:
		$ScrollContainer/HBoxContainer/Level2/Button.mouse_filter = MOUSE_FILTER_IGNORE
		$ScrollContainer/HBoxContainer/Level2/Button.text = "Locked"
	else:
		$ScrollContainer/HBoxContainer/Level2/Button.mouse_filter = MOUSE_FILTER_PASS
		$ScrollContainer/HBoxContainer/Level2/Button.text = "Stream Cipher"

	if not Global.streamComplete:
		$ScrollContainer/HBoxContainer/Level3/Button.mouse_filter = MOUSE_FILTER_IGNORE
		$ScrollContainer/HBoxContainer/Level3/Button.text = "Locked"
	else:
		$ScrollContainer/HBoxContainer/Level3/Button.mouse_filter = MOUSE_FILTER_PASS
		$ScrollContainer/HBoxContainer/Level3/Button.text = "Block Cipher"
	

func _on_level_load_level(level: PackedScene, anim: String) -> void:
	if level == null:
		print("Level was null");
		return;
	Global.game_scene._load_new_level(level, anim);
	queue_free();

func _on_close_button_pressed() -> void:
	$AnimationPlayer.play("close-window")


func _on_close_button_mouse_entered() -> void:
	GlobalSounds.hover.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close-window":
		GlobalSounds.close.play()
		queue_free();

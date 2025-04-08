extends Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	$AnimationPlayer.play("open-window")

	pass
	if Global.caesarComplete == false:
		print("test")
		$"AspectRatioContainer/Level Select Menu/Level2/Button".mouse_filter = MOUSE_FILTER_IGNORE
		$"AspectRatioContainer/Level Select Menu/Level2/RichTextLabel".text = "Locked"
	else:
		$"AspectRatioContainer/Level Select Menu/Level2/Button".mouse_filter = MOUSE_FILTER_PASS
		$"AspectRatioContainer/Level Select Menu/Level2/RichTextLabel".text = "Stream Cipher"
		
	if not Global.streamComplete:
		$"AspectRatioContainer/Level Select Menu/Level3/Button".mouse_filter = MOUSE_FILTER_IGNORE
		$"AspectRatioContainer/Level Select Menu/Level3/RichTextLabel".text = "Locked"
	else:
		$"AspectRatioContainer/Level Select Menu/Level3/Button".mouse_filter = MOUSE_FILTER_PASS
		$"AspectRatioContainer/Level Select Menu/Level3/RichTextLabel".text = "Block Cipher"
	

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

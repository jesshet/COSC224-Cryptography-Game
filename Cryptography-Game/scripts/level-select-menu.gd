extends Control
<<<<<<< Updated upstream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("open-window")

=======
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("open-window")
>>>>>>> Stashed changes

func _on_level_load_level(level: PackedScene, anim: String) -> void:
	if level == null:
		print("Level was null");
		return;
	Global.game_scene._load_new_level(level, anim);
	closeWindow()

func _on_close_button_pressed() -> void:
<<<<<<< Updated upstream
	closeWindow()
	
	
func closeWindow():
	$AnimationPlayer.play("close-window")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close-window":
    GlobalSounds.close.play()
		queue_free();
=======
	$AnimationPlayer.play("close-window")
>>>>>>> Stashed changes


func _on_close_button_mouse_entered() -> void:
	GlobalSounds.hover.play()

<<<<<<< Updated upstream
=======

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close-window":
		GlobalSounds.close.play()
		queue_free();
>>>>>>> Stashed changes

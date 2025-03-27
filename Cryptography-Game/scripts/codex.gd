extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("open-window")


func setTitle(title : String) -> void:
	$"Text-title".text = title

func setBody(body : String) -> void:
	$"Text-body".text = body

func _on_close_button_pressed() -> void:
	$AnimationPlayer.play("close-window")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close-window":
		queue_free()

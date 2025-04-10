extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.menuOpen = true
	$AnimationPlayer.play("open-window")
	if(Global.caesarOpen):
		$"ScrollContainer/VBoxContainer/Caesar-entry".visible = true
	if(Global.streamOpen):
		$"ScrollContainer/VBoxContainer/Stream-entry".visible = true
	if(Global.blockOpen):
		$"ScrollContainer/VBoxContainer/Block-entry".visible = true


func setTitle(title : String) -> void:
	$"Text-title".text = title

func setBody(body : String) -> void:
	$"Text-body".text = body

func _on_close_button_pressed() -> void:
	Global.menuOpen = false
	GlobalSounds.close.play()
	$AnimationPlayer.play("close-window")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close-window":
		queue_free()


func _on_close_button_mouse_entered() -> void:
	GlobalSounds.hover.play()

extends Control
var solution

@export_multiline var levelMessages : Array[String];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	solution = "hello"
	playMessage()
	$DraggableContainerFrame/AnimationPlayer.play("open-window")
	await get_tree().create_timer(0.3).timeout
	$Draggable.visible = true
	$Dragable.visible = true

func playMessage():
	$LevelStack/MessagePlayer.startMessages(levelMessages)
	

func _on_submitbox_submit() -> void:
	var answer = $"submit-box/TextEdit".text
	if(answer == solution):
		var winScreen = preload("res://scenes/level-complete.tscn").instantiate()
		$LevelStack.add_child(winScreen)


func _on_tex_to_hex_message_passer() -> void:
	pass # Replace with function body.


func _on_repeat_text_pressed() -> void:
	playMessage()


func _on_texture_button_mouse_entered() -> void:
	GlobalSounds.hover.play()

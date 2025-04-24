extends Control
#HARD CODE SOLUTION TO LEVEL HERE:
var solution = "PREPARE FOR DESCENT"
var hex_solution
var hex_key
var hex_cipher

var guesses

@export_multiline var levelMessages : Array[String];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	guesses = 0
	#Generate hex key and cipher text based on solution:
	hex_solution = GlobalAlgorithms.text_to_hex(solution)
	hex_key = GlobalAlgorithms.generate_hex_key(hex_solution)
	hex_cipher = GlobalAlgorithms.xor(hex_key, hex_solution)
	#set draggable text to these last two values^
	$Draggable/CenterContainer/text.text = GlobalAlgorithms.hex_to_text(hex_cipher)
	$Dragable/CenterContainer/text.text = hex_key
	
	$Draggable.updateSize()
	$Dragable.updateSize()
	
	playMessage()
	$DraggableContainerFrame/AnimationPlayer.play("open-window")
	await get_tree().create_timer(0.3).timeout
	$Draggable.visible = true
	$Dragable.visible = true
	Global.streamOpen = true

func playMessage():
	$LevelStack/MessagePlayer.startMessages(levelMessages)
	
func _on_submitbox_submit() -> void:
	var answer = $"submit-box/LineEdit".text
	if(answer == solution):
		Global.streamComplete = true
		var winScreen = preload("res://scenes/level-complete.tscn").instantiate()
		$LevelStack.add_child(winScreen)
	else:
		if guesses == 3:
			$LevelStack/MessagePlayer.startMessage("Sample hint text, replace later")
		guesses += 1
		GlobalSounds.incorrect.play()
		$"submit-box/LineEdit".set("theme_override_colors/font_color", Color(1, 0, 0, 1))
		await get_tree().create_timer(0.5).timeout
		$"submit-box/LineEdit".set("theme_override_colors/font_color", Color(1, 1, 1, 1))
		
func _on_repeat_text_pressed() -> void:
	playMessage()


func _on_repeat_text_mouse_entered() -> void:
	GlobalSounds.hover.play()

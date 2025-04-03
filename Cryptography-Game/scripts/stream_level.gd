extends Control
#HARD CODE SOLUTION TO LEVEL HERE:
var solution = "PREPARE FOR DESCENT"
var hex_solution
var hex_key
var hex_cipher

@export_multiline var levelMessages : Array[String];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Generate hex key and cipher text based on solution:
	hex_solution = GlobalAlgorithms.text_to_hex(solution)
	hex_key = GlobalAlgorithms.generate_hex_key(hex_solution)
	hex_cipher = GlobalAlgorithms.xor(hex_key, hex_solution)
	#set draggable text to these last two values^
	$Draggable.text = GlobalAlgorithms.hex_to_text(hex_cipher)
	$Dragable.text = hex_key
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
	else:
		GlobalSounds.incorrect.play()

func _on_repeat_text_pressed() -> void:
	playMessage()


func _on_repeat_text_mouse_entered() -> void:
	GlobalSounds.hover.play()

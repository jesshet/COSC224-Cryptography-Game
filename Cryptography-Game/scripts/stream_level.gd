extends Control
var solution

@export_multiline var levelMessages : Array[String];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	solution = "hello"
	$LevelStack/MessagePlayer.startMessages(levelMessages)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_submitbox_submit() -> void:
	var answer = $"submit-box/TextEdit".text
	if(answer == solution):
		$LevelStack/MessagePlayer.startMessage("you suck")


func _on_tex_to_hex_message_passer() -> void:
	
	pass # Replace with function body.

extends Control
var nodeText1
var nodeText2
var upperCollider
var lowerCollider
var regex

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	regex = RegEx.new()
	regex.compile("^[0-9a-fA-F]*$")
	upperCollider = $Control/UpperBox
	lowerCollider = $Control2/LowerBox
	nodeText1 = ""
	nodeText2 = ""
	$AnimationPlayer.play("open-window")
	

func _on_xorbtn_pressed() -> void:
	if not (upperCollider.filled and lowerCollider.filled):
		$"../MessagePlayer".startMessage("You need to supply two input values")
		return
	nodeText1 = upperCollider.node.text
	nodeText2 = lowerCollider.node.text
	if nodeText1.length() != nodeText2.length():
		$"../MessagePlayer".startMessage("Invalid input: make sure that the two values are the same length.")
		return
	var result = regex.search(nodeText1)
	if not result:
		$"../MessagePlayer".startMessage("Invalid upper input: Please provide a valid hexadecimal value.")
	result = regex.search(nodeText2)
	if not result:
		$"../MessagePlayer".startMessage("Invalid lower input: Please provide a valid hexadecimal value.")
	var output = GlobalAlgorithms.xor(nodeText1, nodeText2)
	#XOR Result is Hex Unit Test:
	result = regex.search(output)
	if(result):
		print("Test case: XOR result is in Hexadecimal: Success")
	else:
		print("Test case: XOR result is in Hexadecimal: Failure")
	animateChange(upperCollider.node.text, output)
	
func animateChange(currentWord, targetWord):
	upperCollider.node.mouse_filter = MOUSE_FILTER_IGNORE
	var loop = 0
	var count = 0
	while(loop < 4):
		while(count < targetWord.length()):
			
			if(loop < 3):
				currentWord[count] = get_random_char()
			else:
				currentWord[count] = targetWord[count]
			count += 1

			await get_tree().create_timer(0.001).timeout
			upperCollider.node.text = currentWord
			GlobalSounds.click.play()
      
		count = 0
		loop += 1
	#setInfo(currentWord)
	upperCollider.node.mouse_filter = MOUSE_FILTER_STOP
		
func get_random_char():
	var random_number = randi() % 26
	var characters = 'abcdefghijklmnopqrstuvwxyz'
	return characters[random_number]


func _on_xorbtn_mouse_entered() -> void:
	GlobalSounds.hover.play()


func _on_decrypt_btn_mouse_entered() -> void:
	GlobalSounds.hover.play()

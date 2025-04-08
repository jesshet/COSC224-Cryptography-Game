extends Control
#TEST PUSH
var nodeText
var regex
var textNode
var textBox
var infoSet
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Setting the regex that will match hexadecimel strings
	infoSet = false
	textBox = $CollisionContainer/Area2D
	nodeText = ""
	regex = RegEx.new()
	regex.compile("^[0-9a-fA-F]*$")
	$AnimationPlayer.play("open-window")

func _process(delta: float) -> void:
	if textBox.filled && !infoSet:
		setInfo(textBox.textNode.text)
		infoSet = true
	if !textBox.filled && infoSet:
		infoClear()
		infoSet = false

func _on_text_to_hex_btn_pressed() -> void:
	if not textBox.filled: return
	nodeText = textBox.textNode.text
	var result = regex.search(nodeText)
	if result: #nodeText is already in hex
		$"../MessagePlayer".startMessage("Input text appears to be in Hexadecimal already. Conversion failed.")
		return
	var output = GlobalAlgorithms.text_to_hex(nodeText)
	animateChange(textBox.textNode.text, output)

func _on_hex_to_text_btn_pressed() -> void:
	if not textBox.filled: return
	nodeText = textBox.textNode.text
	var result = regex.search(nodeText)
	if not result: #nodeText is not in hex
		$"../MessagePlayer".startMessage("Invalid input: Please provide a valid hexadecimal string.")
		return
	var output = GlobalAlgorithms.hex_to_text(nodeText)
	animateChange(textBox.textNode.text, output)

func setInfo(s):
	var result = regex.search(s)
	if result:
		$Info.text = "HEX"
	else:
		$Info.text = "TEXT"
		
func infoClear():
	$Info.text = ""

func animateChange(currentWord, targetWord):
	textBox.node.mouse_filter = MOUSE_FILTER_IGNORE
	var count = 0
	var step = abs(targetWord.length() - currentWord.length()) / 10
	var check = true
	
	for n in 40:
		
		while count < currentWord.length():
			if n % 2 == 0:	#change even character
				if count % 2 == 0:
					currentWord[count] = get_random_char()
			else:	#change odd characters
				if count+1 % 2 == 0:
					currentWord[count] = get_random_char()
			count += 1
			
			updateText(textBox.node, textBox.textNode, currentWord.replace(" ",""))
			
		await get_tree().create_timer(0.03).timeout
		GlobalSounds.click.play()
		count = 0
		
		if currentWord.length() < targetWord.length():
			for i in step:
				currentWord += get_random_char()
				

		if currentWord.length() > targetWord.length():
			currentWord = currentWord.left(currentWord.length() - step)
			
	GlobalSounds.finishDec.play()
	updateText(textBox.node, textBox.textNode, targetWord)

	textBox.node.mouse_filter = MOUSE_FILTER_STOP

func updateText(messageNode, textNode, message):
	textNode.text = message
	messageNode.updateSize()
	messageNode.global_position = $CollisionContainer.global_position + ($CollisionContainer.size - messageNode.size)/2;
	

func get_random_char():
	var random_number = randi() % 57
	var characters = 'abcdefghijklmnopqrstuvwxyz<>?:"{}!@#$%^&*()_+-=1234567890'
	return characters[random_number]
	
func _on_text_to_hex_btn_mouse_entered() -> void:
	GlobalSounds.hover.play()


func _on_hex_to_text_btn_mouse_entered() -> void:
	GlobalSounds.hover.play()

extends Control

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
		setInfo(textBox.node.text)
		infoSet = true
	if !textBox.filled && infoSet:
		infoClear()
		infoSet = false

func _on_text_to_hex_btn_pressed() -> void:
	if not textBox.filled: return
	nodeText = textBox.node.text
	var result = regex.search(nodeText)
	if result: #nodeText is already in hex
		$"../MessagePlayer".startMessage("Input text appears to be in Hexadecimal already. Conversion failed.")
		return
	var output = GlobalAlgorithms.text_to_hex(nodeText)
	animateChange(textBox.node.text, output)

func _on_hex_to_text_btn_pressed() -> void:
	if not textBox.filled: return
	nodeText = textBox.node.text
	var result = regex.search(nodeText)
	if not result: #nodeText is not in hex
		$"../MessagePlayer".startMessage("Invalid input: Please provide a valid hexadecimal string.")
		return
	var output = GlobalAlgorithms.hex_to_text(nodeText)
	animateChange(textBox.node.text, output)

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
	while(currentWord != targetWord):
		while(count < targetWord.length()):
			
			if count < currentWord.length() - 1:
				currentWord[count] = get_random_char()
			
			if count >= currentWord.length():
				currentWord += get_random_char()
				
				
			if count == targetWord.length() - 1 && currentWord.length() > targetWord.length():
				currentWord = currentWord.left(currentWord.length() - 1)
				break
				
			if currentWord.length() == targetWord.length():
				currentWord[count] = targetWord[count]
				
			count += 1
			if currentWord.length() > targetWord.length():
				await get_tree().create_timer(0.01).timeout
			else:
				await get_tree().create_timer(0.01).timeout
			textBox.node.text = currentWord
			GlobalSounds.click.play()
		count = 0
	setInfo(currentWord)
	textBox.node.mouse_filter = MOUSE_FILTER_STOP
		
func get_random_char():
	var random_number = randi() % 26
	var characters = 'abcdefghijklmnopqrstuvwxyz'
	return characters[random_number]
	


func _on_text_to_hex_btn_mouse_entered() -> void:
	GlobalSounds.hover.play()


func _on_hex_to_text_btn_mouse_entered() -> void:
	GlobalSounds.hover.play()

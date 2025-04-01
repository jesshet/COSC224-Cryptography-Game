extends Control

var _inputText
var regex
var textNode
var textBox
var infoSet
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Setting the regex that will match hexadecimel strings

	infoSet = false
	textBox = $CollisionContainer/Area2D
	_inputText = ""
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
	print("press text - to - hex")
	if not textBox.filled: return
	_inputText = textBox.node.text ##CHANGE THIS TO GET INSTANCE VARIABLE RATHER THAN DISPLAYED TEXT
	var result = regex.search(_inputText)
	if result: #This means if the result matches the hex regex
		#CALL METHOD OR HINT DISPLAYING USER ERROR
		$"../MessagePlayer".startMessage("Input text appears to be in Hexadecimal already. Conversion failed.")
		#return unchanged input string
		return
		
	var hex = ""
	#redo:
	var i = 0
	while i < _inputText.length():
		print("Loop iteration start. i = ")
		print(i)#switch to 32 offset and use tilde as escape char
		print("Looking at input char: " + _inputText[i])
		if _inputText[i] == "~":
			var byte1 = _inputText.substr(i+1, 1).to_utf8_buffer()[0] - 32
			print("Half Byte 1: %x" % byte1)
			var byte2 = _inputText.substr(i+2, 1).to_utf8_buffer()[0] - 32
			print("Half Byte 2: %x" % byte1)
			hex += String("%x" % byte1)
			hex += String("%x" % byte2)
			i += 3
		else:
			var byte = _inputText.substr(i, 1).to_utf8_buffer()[0] - 32
			print(_inputText.substr(i, 1) + "becomes big byte: %02x" % byte)
			hex += String("%02x" % byte)
			#print(_inputText.substr(i, 2) - 34)
			i += 1
		print("i is now ")
		print(i)
	print("End string: " + hex)
	
	#var bytes = _inputText.to_utf8_buffer()
	#print(bytes)
	#for byte in bytes:
	#	hex += String("%02x" % byte)
	_inputText = hex.replace(" ","").to_upper()
	#textBox.node.text = _inputText
	animateChange(textBox.node.text, _inputText)

func _on_hex_to_text_btn_pressed() -> void:
	print("press hex - to - tex")
	if not textBox.filled: return
	_inputText = textBox.node.text
	# Validate hexadecimal input
	var result = regex.search(_inputText)
	if not result:
		#CALL METHOD TO DISPLAY HINT STATING THAT USER DID NOT PROVIDE HEX INPUT
		$"../MessagePlayer".startMessage("Invalid input: Please provide a valid hexadecimal string.")
		#return unchanged input string
		return
	var display_plaintext = ""
	var bytes = PackedByteArray()
	for i in range(0, _inputText.length(), 2):
		var byte_hex = _inputText.substr(i, 2)
		byte_hex = byte_hex #make sure it starts at '!'
		if byte_hex.hex_to_int() + 34 > 133 :
			var b1 = byte_hex.substr(0,1).hex_to_int() + 32
			var b2 = byte_hex.substr(1,2).hex_to_int() + 32
			display_plaintext = display_plaintext + "~" + char(b1) + char(b2)
		else:
			display_plaintext += char(byte_hex.hex_to_int() + 32)
		#bytes.append(byte_hex)
	#_inputText = bytes.get_string_from_utf8()
	print(display_plaintext)
	#animateChange(textBox.node.text, _inputText)
	animateChange(textBox.node.text, display_plaintext)


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
				await get_tree().create_timer(0.005).timeout
			textBox.node.text = currentWord
		count = 0
	setInfo(currentWord)
	textBox.node.mouse_filter = MOUSE_FILTER_STOP
		
func get_random_char():
	var random_number = randi() % 26
	var characters = 'abcdefghijklmnopqrstuvwxyz'
	return characters[random_number]
	

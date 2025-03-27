extends Control

var _inputText
var regex
var textNode
var textBox
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Setting the regex that will match hexadecimel strings
	textBox = $Area2D
	_inputText = ""
	regex = RegEx.new()
	regex.compile("^[0-9a-fA-F]*$")

func _on_text_to_hex_btn_pressed() -> void:
	print("press text - to - hex")
	if not textBox.filled: return
	
	_inputText = textBox.node.text
	var result = regex.search(_inputText)
	if result: #This means if the result matches the hex regex
		#CALL METHOD OR HINT DISPLAYING USER ERROR
		print("Input text appears to be in Hexadecimal already. Conversion failed.")
		#return unchanged input string
		return
		
	var hex = ""
	var bytes = _inputText.to_utf8_buffer()
	for byte in bytes:
		hex += String("%02x" % byte)
	_inputText = hex.replace(" ","").to_upper()
	textBox.node.text = _inputText

func _on_hex_to_text_btn_pressed() -> void:
	print("press hex - to - tex")
	if not textBox.filled: return
	
	_inputText = textBox.node.text
	# Validate hexadecimal input
	var result = regex.search(_inputText)
	if not result:
		#CALL METHOD TO DISPLAY HINT STATING THAT USER DID NOT PROVIDE HEX INPUT
		print("Invalid input: Please provide a valid hexadecimal string.")
		#return unchanged input string
		return
		
	var bytes = PackedByteArray()
	for i in range(0, _inputText.length(), 2):
		var byte_hex = _inputText.substr(i, 2)
		bytes.append(byte_hex.hex_to_int())
	_inputText = bytes.get_string_from_utf8()
	textBox.node.text = _inputText
	

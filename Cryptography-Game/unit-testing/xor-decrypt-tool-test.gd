extends Control
var _inputUpper
var _inputLower
var nodeUpper
var nodeLower
var upperCollider
var lowerCollider
var regex
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	regex = RegEx.new()
	regex.compile("^[0-9a-fA-F]*$")
	upperCollider = $Control/UpperBox
	lowerCollider = $Control2/LowerBox
	nodeUpper = null
	nodeLower = null
	_inputUpper = ""
	_inputLower = ""
	pass # Replace with function body.

func _on_xorbtn_pressed() -> void:
	print("works here")
	if not (upperCollider.filled and lowerCollider.filled):
		print("You need to supply two inputs")
		return
	print("works here")
	nodeUpper = upperCollider.node
	nodeLower = lowerCollider.node
	_inputUpper = nodeUpper.text
	_inputLower = nodeLower.text
	var result = regex.search(_inputUpper)
	if not result:
		print("Invalid input: Please provide a valid hexadecimal string.")
	result = regex.search(_inputLower)
	if not result:
		print("Invalid key: Please provide a valid hexadecimal key.")
	var xor_result = ""
	for i in range(0, _inputUpper.length(), 2):
		var byte_hex1 = _inputUpper.substr(i, 2).hex_to_int()
		var byte_hex2 = _inputLower.substr(i, 2).hex_to_int()
		var xor_byte = byte_hex1 ^ byte_hex2
		xor_result += String("%02x" % xor_byte)
	nodeUpper.text = xor_result.replace(" ","").to_upper()
	
func _on_decrypt_btn_pressed() -> void:
	print("works here")
	if not (upperCollider.filled and lowerCollider.filled):
		print("You need to supply two inputs")
		return
	print("works here")
	
	#Load in Upper and Lower Draggables
	nodeUpper = upperCollider.node
	nodeLower = lowerCollider.node
	
	#Set Input text
	_inputUpper = nodeUpper.text
	_inputLower = nodeLower.text
	
	#Check Regex Against Input
	var result = regex.search(_inputUpper)
	if not result:
		print("Invalid input: Please provide a valid hexadecimal string.")
	result = regex.search(_inputLower)
	if not result:
		print("Invalid key: Please provide a valid hexadecimal key.")
	var xor_result = ""
	
	for i in range(0, _inputUpper.length(), 2):
		var byte_hex1 = _inputUpper.substr(i, 2).hex_to_int()
		var byte_hex2 = _inputLower.substr(i, 2).hex_to_int()
		var xor_byte = byte_hex1 ^ byte_hex2
		xor_result += String("%02x" % xor_byte)
	
	
	
func _xor_testing(_inputUpper, _inputLower):
	var result = regex.search(_inputUpper)
	if not result:
		print("Invalid input: Please provide a valid hexadecimal string.")
	result = regex.search(_inputLower)
	if not result:
		print("Invalid key: Please provide a valid hexadecimal key.")
	var xor_result = ""
	for i in range(0, _inputUpper.length(), 2):
		var byte_hex1 = _inputUpper.substr(i, 2).hex_to_int()
		var byte_hex2 = _inputLower.substr(i, 2).hex_to_int()
		var xor_byte = byte_hex1 ^ byte_hex2
		xor_result += String("%02x" % xor_byte)
	var returnText = xor_result.replace(" ","").to_upper()
	return returnText

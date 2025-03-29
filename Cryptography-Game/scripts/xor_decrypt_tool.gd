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
	if not (upperCollider.filled and lowerCollider.filled):
		$"../MessagePlayer".startMessage("You need to supply two inputs")
		return
	nodeUpper = upperCollider.node
	nodeLower = lowerCollider.node
	_inputUpper = nodeUpper.text
	_inputLower = nodeLower.text
	if _inputUpper.length() != _inputLower.length():
		$"../MessagePlayer".startMessage("Invalid input: make sure that the two strings are the same length.")
		return
	var result = regex.search(_inputUpper)
	if not result:
		$"../MessagePlayer".startMessage("Invalid input: Please provide a valid hexadecimal string.")
	result = regex.search(_inputLower)
	if not result:
		$"../MessagePlayer".startMessage("Invalid key: Please provide a valid hexadecimal key.")
	var xor_result = ""
	for i in range(0, _inputUpper.length(), 2):
		var byte_hex1 = _inputUpper.substr(i, 2).hex_to_int()
		var byte_hex2 = _inputLower.substr(i, 2).hex_to_int()
		var xor_byte = byte_hex1 ^ byte_hex2
		xor_result += String("%02x" % xor_byte)
		xor_result = xor_result.replace(" ","").to_upper()
	#XOR Result is Hex Unit Test:
	result = regex.search(xor_result)
	if(result):
		print("Test case XOR result is in Hexadecimal: Success")
	else:
		print("Test case XOR result is in Hexadecimal: Failure")
	animateChange(nodeUpper.text, xor_result)
	

func animateChange(currentWord, targetWord):
	nodeUpper.mouse_filter = MOUSE_FILTER_IGNORE
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
			nodeUpper.text = currentWord
		count = 0
		loop += 1
	#setInfo(currentWord)
	nodeUpper.mouse_filter = MOUSE_FILTER_STOP
		
func get_random_char():
	var random_number = randi() % 26
	var characters = 'abcdefghijklmnopqrstuvwxyz'
	return characters[random_number]

extends Button

@export var _rayCenter: RayCast2D;
@export var _inputTBX: TextEdit;
var _lastMousePos: Vector2;
var _isDragging: bool = false;
var regex


func  _ready() -> void:
	#Setting the regex that will match hexadecimel strings
	regex = RegEx.new()
	regex.compile("^[0-9a-fA-F]*$")
	
	if _rayCenter == null:
		printerr(name + "'s raycast is null");
	else:
		_rayCenter.position = Vector2(position.x + size.x/2, position.y + size.y/2);
	pass;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _isDragging:
		var newMousePos = get_viewport().get_mouse_position();
		position += (newMousePos-_lastMousePos);
		_lastMousePos = newMousePos;
	pass;


func _on_button_down() -> void:
	_lastMousePos = get_viewport().get_mouse_position();
	_isDragging = true;
	pass # Replace with function body.


func _on_button_up() -> void:
	var currentMousePos = get_viewport().get_mouse_position();
	if _rayCenter.is_colliding(): #move to center of drop in box
		var colliderParent = _rayCenter.get_collider().get_parent()
		print(_rayCenter.get_collider().get_parent())
		position = colliderParent.position + (colliderParent.size - size)/2;
		if(colliderParent.get_name() == "TexToHex"):
			self.text = text_to_hex(self.text)
		if(colliderParent.get_name() == "HexToTex"):
			self.text = hex_to_text(self.text)
		if(colliderParent.get_name() == "XOR"):
			var key = _inputTBX.text #key length checked in xor method
			self.text = xor(self.text, key)
	_isDragging = false;
	pass # Replace with function body.


func text_to_hex(input: String) -> String:
	var result = regex.search(input)
	if result: #This means if the result matches the hex regex
		#CALL METHOD OR HINT DISPLAYING USER ERROR
		print("Input text appears to be in Hexadecimal already. Conversion failed.")
		#return unchanged input string
		return input
	var hex = ""
	var bytes = input.to_utf8_buffer()
	for byte in bytes:
		hex += String("%02x" % byte)
	return hex.replace(" ","").to_upper()

func hex_to_text(input: String) -> String:
	# Validate hexadecimal input
	var result = regex.search(input)
	if not result:
		#CALL METHOD TO DISPLAY HINT STATING THAT USER DID NOT PROVIDE HEX INPUT
		print("Invalid input: Please provide a valid hexadecimal string.")
		#return unchanged input string
		return input
	var bytes = PackedByteArray()
	for i in range(0, input.length(), 2):
		var byte_hex = input.substr(i, 2)
		bytes.append(byte_hex.hex_to_int())
	return bytes.get_string_from_utf8()

func xor(in1: String, in2: String) -> String:
	if not in1.length() == in2.length():
		print("KEY LENGTH DOES NOT MATCH INPUT LENGTH")
		return in1
	var result = regex.search(in1)
	if not result:
		print("Invalid input: Please provide a valid hexadecimal string.")
	result = regex.search(in2)
	if not result:
		print("Invalid key: Please provide a valid hexadecimal key.")
	var xor_result = ""
	for i in range(0, in1.length(), 2):
		var byte_hex1 = in1.substr(i, 2).hex_to_int()
		var byte_hex2 = in2.substr(i, 2).hex_to_int()
		var xor_byte = byte_hex1 ^ byte_hex2
		xor_result += String("%02x" % xor_byte)  # Keep it in recognizable hex
	return xor_result.replace(" ","").to_upper()

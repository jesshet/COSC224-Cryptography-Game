extends Control
var solution
var hex_key
var display_cipher
var hex_cipher
@export_multiline var levelMessages : Array[String];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	solution = "Prepare for Descent"
	sol_to_hex(solution)
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


func _on_tex_to_hex_message_passer() -> void:
	
	pass # Replace with function body.


func _on_repeat_text_pressed() -> void:
	playMessage()
	
	
	##################################
func sol_to_hex(s) -> void:
	#convert solution to hex
	#get that length and generate a random hex key of that length
	
	#1. Turn Solution Text to Hex:
	var hex_solution = ""
	var bytes = s.to_utf16_buffer()
	var z = 0
	for byte in bytes:
		if z % 2 == 0:
			hex_solution += String("%x" % byte)
		z += 1
	hex_solution = hex_solution.replace(" ","").to_upper()
	
	#2. Generate Hex Key of same Length
	var keyLength = hex_solution.length()
	var hex_key = ""
	for i in range(0, keyLength, 2):
		# Generate a random number between 0 and 15 (hex range) and convert to hexadecimal.
		var rand_val = randi() % 255
		hex_key += String("%02x" % rand_val)
	
	
	print("Solution in hex: " + hex_solution)
	print("Hex key: " + hex_key)
	
	#3. XOR to get cipher Hex
	var hex_cipher = ""
	for i in range(0, hex_key.length(), 2):
		var byte_hex1 = hex_solution.substr(i, 2).hex_to_int()
		var byte_hex2 = hex_key.substr(i, 2).hex_to_int()
		var xor_byte = byte_hex1 ^ byte_hex2
		hex_cipher += String("%02x" % xor_byte)
		hex_cipher = hex_cipher.replace(" ","").to_upper()
	print("Hex cipher: " + hex_cipher)
	
	#4. Get plain cipher text from cipher hex
	#var plain_cipher = PackedByteArray()
	var plain_cipher = ""
	for i in range(0, hex_cipher.length(), 2):
		var byte_hex = hex_cipher.substr(i, 2)
		var char_code = byte_hex.hex_to_int()
		plain_cipher += char(char_code)
		#plain_cipher.append(byte_hex.hex_to_int())
	#plain_cipher = plain_cipher.get_string_from_utf16()
	var regex = RegEx.new()
	regex.compile("[\\n\\r\\u2028\\u2029\\u000A\\u000B\\u000C\\u0085\\u000D]") # Matches various newline characters
	regex.sub(plain_cipher, "", true)
	print("Plain Cipher: " + plain_cipher)

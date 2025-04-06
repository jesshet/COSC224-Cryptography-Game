extends Node

func text_to_hex(s) -> String:
	var input = s
	var output = ""
	var i = 0
	while i < input.length():
		if input[i] == "~":
			var halfbyte1 = input.substr(i+1, 1).to_utf8_buffer()[0] - 32
			var halfbyte2 = input.substr(i+2, 1).to_utf8_buffer()[0] - 32
			output += String("%x" % halfbyte1)
			output += String("%x" % halfbyte2)
			i += 3
		else:
			var byte = input.substr(i, 1).to_utf8_buffer()[0] - 32
			output += String("%02x" % byte)
			i += 1
	output = output.replace(" ","").to_upper()
	return output

func hex_to_text(s) -> String:
	var input = s
	var output = ""
	for i in range(0, input.length(), 2):
		var byte = input.substr(i, 2)
		if byte.hex_to_int() + 32 > 91 :
			var halfbyte1 = byte.substr(0,1).hex_to_int() + 32
			var halfbyte2 = byte.substr(1,2).hex_to_int() + 32
			output = output + "~" + char(halfbyte1) + char(halfbyte2)
		else:
			byte = byte.hex_to_int() + 32
			output += char(byte)
	return output

func generate_hex_key(s) -> String:
	var keyLength = s.length()
	var output = ""
	for i in range(0, keyLength, 2):
		# Generate a random number between 0 and 15 (hex range) and convert to hexadecimal.
		var rand_val = randi() % 255
		output += String("%02x" % rand_val)
		output = output.to_upper()
	return output
	
func xor(s1, s2) -> String:
	var output = ""
	for i in range(0, s1.length(), 2):
		var byte1 = s1.substr(i, 2).hex_to_int()
		var byte2 = s2.substr(i, 2).hex_to_int()
		var xor_byte = byte1 ^ byte2
		output += String("%02x" % xor_byte)
		output = output.to_upper()
	return output

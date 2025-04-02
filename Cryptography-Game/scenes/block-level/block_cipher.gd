extends Control

@export var _text: Area2D;
@export var _init: Area2D;
@export var _key: Area2D;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _operation() -> void:
	
	pass;


func _computeOut() -> String:
	if _text.filled and _init.filled and _key.filled:
		var textBytes = _text._data.to_utf8_buffer();
		var initBytes = _init._data.to_utf8_buffer();
		var xor_result = "";
		for i in range(0, textBytes.length()):
			xor_result += char(textBytes.sub_string(i,1) ^ initBytes.sub_string(i,1));
			pass;
		
		var keyBytes = _key._data.to_utf8_buffer();
		var bytes = xor_result.to_utf8_buffer();
		var answer = "";
		for i in range(0, textBytes.length()):
			answer += char((bytes.sub_string(i,1) + keyBytes.sub_string(i,1)) % 256);
			pass;
		
		return answer;
		pass;
	return "";
	
func _computeIn(ans: String, init: String, key: String) -> PackedByteArray:
	var keyBytes = key.to_utf8_buffer();
	var ansBytes = ans.to_utf8_buffer();
	var encrypted = [];
	for i in range(0, ansBytes.size()):
		encrypted.append((ansBytes[i] + keyBytes[i]) % 256);
		pass;
	
	#var	result = "";
	var initBytes = init.to_utf8_buffer();
	var xor_result:PackedByteArray = [];
	for i in range(0, encrypted.size()):
		xor_result.append(encrypted[i] ^ initBytes[i]);
		#result += ("%c" % xor_result[i]);
		pass;
	
	return xor_result;

func _toHex(str: String) -> String:
	var hex = ""
	var bytes = str.to_utf8_buffer()
	for byte in bytes:
		hex += String("%02x" % byte)
	return hex;

func _toHexPBA(str: PackedByteArray) -> String:
	var hex = ""
	for byte in str:
		hex += String("%02x" % byte)
	return hex;

extends Control

@export var _text: Area2D;
@export var _init: Area2D;
@export var _key: Area2D;

@export var _answer: String;
@export var _keyStr: String;
@export var _initStr: String;
var _textStr: PackedByteArray;

@export var _output: Label;

enum Type {NA, Init, Key, Text};

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _operation() -> void:
	
	pass;


func _computeOut() -> String:
	if !_text.filled and !_init.filled and !_key.filled:
		return "Error";
	
	if _text.node._type == Type.Text and _key.node._type == Type.Key and _init.node._type == Type.Init:
		var textBytes = _textStr;
		var initBytes = _initStr.to_utf8_buffer();
		var xor_result:PackedByteArray = [];
		for i in range(0, textBytes.size()):
			xor_result.append(textBytes[i] ^ initBytes[i]);
			pass;
		print(xor_result);
		var keyBytes = _keyStr.to_utf8_buffer();
		var answer:PackedByteArray = [];
		for i in range(0, textBytes.size()):
			answer.append((xor_result[i] + keyBytes[i]) % 256);
			pass;
		
		return answer.hex_encode();
		pass;
	return "Miss Placed";
	
func _computeIn() -> PackedByteArray:
	var keyBytes = _keyStr.to_utf8_buffer();
	var ansBytes = _answer.to_utf8_buffer();
	var encrypted = [];
	for i in range(0, ansBytes.size()):
		encrypted.append((ansBytes[i] + keyBytes[i]) % 256);
		pass;
	
	#var	result = "";
	var initBytes = _initStr.to_utf8_buffer();
	var xor_result:PackedByteArray = [];
	for i in range(0, encrypted.size()):
		xor_result.append(encrypted[i] ^ initBytes[i]);
		#result += ("%c" % xor_result[i]);
		pass;
	_textStr = xor_result;
	print(xor_result);
	return xor_result;

func _toHex(str: String) -> String:
	var hex = "";
	var bytes = str.to_utf8_buffer();
	for byte in bytes:
		hex += String("%02x" % byte);
	return hex;

func _toHexPBA(str: PackedByteArray) -> String:
	var hex = "";
	for byte in str:
		hex += String("%02x" % byte)
	return hex;

func _box_populated() -> void:
	print("Pop");
	var output = _computeOut();
	_output.text = output;
	pass;

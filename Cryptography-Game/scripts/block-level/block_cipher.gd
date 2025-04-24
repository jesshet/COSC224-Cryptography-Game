extends Control

@export var _text: Area2D;
@export var _init: Area2D;
@export var _key: Area2D;

@export var _output: RichTextLabel;

@export var _level: Control;

enum Type {NA, Init, Key, Text};


#Check if all field are populated with the correctly labeled types
func _box_populated() -> void:
	if _text.node == null or _key.node == null or _init.node == null:
		_output.text = "Some fields are empty";
	elif _text.node._type == Type.Text and _key.node._type == Type.Key and _init.node._type == Type.Init:
		_output.text = _level._answer;
	elif _text.node._type != Type.Text:
		_output.text = "Incorrect Plain Text";
	elif _key.node._type != Type.Key:
		_output.text = "Incorrect Key";
	elif _init.node._type != Type.Init:
		_output.text = "Incorrect Initialization Value";
	pass;

extends Control

@export var _text: Area2D;
@export var _init: Area2D;
@export var _key: Area2D;

@export var _output: Label;

@export var _level: Control;

enum Type {NA, Init, Key, Text};


#Check if all field are populated with the correctly labeled types
func _box_populated() -> void:
	if _text.node._type == Type.Text and _key.node._type == Type.Key and _init.node._type == Type.Init:
		_output.text = _level._answer;
		pass;
	else:
		_output.text = "Error";
	pass;

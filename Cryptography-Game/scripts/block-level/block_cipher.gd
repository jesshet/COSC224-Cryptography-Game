extends Control

@export var _text: Area2D;
@export var _init: Area2D;
@export var _key: Area2D;

var _answer: String = "Error";
@export var _keyStr: String;
@export var _initStr: String;
@export var _plainText: String;

@export var _output: Label;

enum Type {NA, Init, Key, Text};



func _box_populated() -> void:
	if _text.node._type == Type.Text and _key.node._type == Type.Key and _init.node._type == Type.Init:
		_output.text = _answer;
		pass;
	else:
		_output.text = "Error";
	pass;

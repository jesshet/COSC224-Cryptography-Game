extends HBoxContainer

signal load_level(level);

@export var _buttonText = "";
@export var _boxText = "";
@export var _level:PackedScene;
@export var _animName = ""

var _button: Button;
var _textBox: RichTextLabel;
var _parentNode: Node;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_button = get_node("Button");
	_textBox = get_node("RichTextLabel");
	_button.text = _buttonText;
	_button.text += ". " + _boxText;
	_parentNode = get_parent();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	load_level.emit(_level, _animName);

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
	_textBox.text = _boxText;
	_parentNode = get_parent();
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	GlobalSounds.musicVol = GlobalSounds.music.get_volume_db()
	GlobalSounds.music.set_volume_db(-200)
	GlobalSounds.load.play()
	GlobalSounds._fade_music()
	await get_tree().create_timer(1).timeout
		
	load_level.emit(_level, _animName);


func _on_button_mouse_entered() -> void:
	GlobalSounds.hover.play()

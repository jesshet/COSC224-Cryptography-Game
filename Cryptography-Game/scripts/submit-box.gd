extends Control
signal submit

@export var _textBox: TextEdit;
@export var _submitButton: TextureButton;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(_textBox != null, "The textBox for the submit button is null");
	$AnimationPlayer.play("open-window")
	
func _on_texture_button_pressed() -> void:
	if Global._winState: #prevent multiple winscreens
		return;
	submit.emit();

func  _input(event: InputEvent) -> void:
	if _textBox.has_focus() and event is InputEventKey and event.is_pressed():
		if Global._winState: #prevent typing in text box after winscreen
			get_viewport().set_input_as_handled();
			return;
		if event.key_label == KEY_ENTER:
			_on_texture_button_pressed();
			get_viewport().set_input_as_handled();
			pass;
		pass;
	pass;

func _on_text_edit_text_changed() -> void:
	var pos = _textBox.get_caret_column();
	var text = _textBox.text.to_upper();
	_textBox.text = text;
	_textBox.set_caret_column(pos);
	GlobalSounds.click.play()


func _on_texture_button_mouse_entered() -> void:
	GlobalSounds.hover.play()

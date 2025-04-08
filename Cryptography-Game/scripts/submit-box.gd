extends Control
signal submit

@export var _textBox: TextEdit;
@export var _submitButton: TextureButton;
var _disabled: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(_textBox != null, "The textBox for the submit button is null");
	$AnimationPlayer.play("open-window")


func _on_texture_button_pressed() -> void:
	submit.emit();

func  _input(event: InputEvent) -> void:
	if _textBox.has_focus() and event is InputEventKey and event.is_pressed():
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


func _on_line_edit_text_changed(new_text: String) -> void:
	GlobalSounds.click.play()

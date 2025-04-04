extends Control
signal submit

@export var _textBox: TextEdit;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(_textBox != null, "The textBox for the submit button is null");
	$AnimationPlayer.play("open-window")


func _on_texture_button_pressed() -> void:
	submit.emit();


func _on_text_edit_text_changed() -> void:
	var pos = _textBox.get_caret_column();
	_textBox.text = _textBox.text.to_upper();
	_textBox.set_caret_column(pos);
	GlobalSounds.click.play()


func _on_texture_button_mouse_entered() -> void:
	GlobalSounds.hover.play()

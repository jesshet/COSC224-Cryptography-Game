extends Button

var _lastMousePos: Vector2;
var _isDragging: bool = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _isDragging:
		var newMousePos = get_viewport().get_mouse_position();
		position += (newMousePos-_lastMousePos);
		_lastMousePos = newMousePos;
		pass


func _on_button_down() -> void:
	_lastMousePos = get_viewport().get_mouse_position();
	_isDragging = true;
	pass # Replace with function body.


func _on_button_up() -> void:
	_isDragging = false;
	pass # Replace with function body.

extends Button

@export var _rayCenter: RayCast2D;
var _lastMousePos: Vector2;
var _isDragging: bool = false;


func  _ready() -> void:
	if _rayCenter == null:
		printerr(name + "'s raycast is null");
	else:
		_rayCenter.position = Vector2(position.x + size.x/2, position.y + size.y/2);
	pass;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _isDragging:
		var newMousePos = get_viewport().get_mouse_position();
		position += (newMousePos-_lastMousePos);
		_lastMousePos = newMousePos;
	pass;


func _on_button_down() -> void:
	_lastMousePos = get_viewport().get_mouse_position();
	_isDragging = true;
	pass # Replace with function body.


func _on_button_up() -> void:
	var currentMousePos = get_viewport().get_mouse_position();
	if _rayCenter.is_colliding(): #move to center of drop in box
		var colliderParent = _rayCenter.get_collider().get_parent();
		position = colliderParent.position + (colliderParent.size - size)/2;
	_isDragging = false;
	pass # Replace with function body.

extends Button

@export var _rayCenter: RayCast2D;
@export var _inputTBX: TextEdit;
var _lastMousePos: Vector2;
var _isDragging: bool = false;
var startPos: Vector2

func  _ready() -> void:
	assert(_rayCenter != null, name + "'s raycast is null");
	
	startPos = Vector2(global_position.x + size.x/2, global_position.y + size.y/2);
	_rayCenter.global_position = Vector2(global_position.x + size.x/2, global_position.y + size.y/2);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _isDragging:
		var newMousePos = get_viewport().get_mouse_position();
		position += (newMousePos-_lastMousePos);
		_lastMousePos = newMousePos;


func _on_button_down() -> void:
	_lastMousePos = get_viewport().get_mouse_position();
	_isDragging = true;
	if _rayCenter.is_colliding():
		var collider = _rayCenter.get_collider()
		collider.depopulate()


func _on_button_up() -> void:
	_isDragging = false;
	var collide = false
	var currentMousePos = get_viewport().get_mouse_position();
	if _rayCenter.is_colliding(): #move to center of drop in box
		var colliderParent = _rayCenter.get_collider().get_parent();
		global_position = colliderParent.global_position + (colliderParent.size - size)/2;
		
		var collider = _rayCenter.get_collider()
		if collider.checkAndFill(self):
			collide = true
			
	if not collide:
		resetPosition()

	_isDragging = false;
	
func resetPosition():
	self.global_position = startPos

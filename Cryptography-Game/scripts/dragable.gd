#@tool

extends TextureButton

@export var _rayCenter: RayCast2D;

@export var textNode: RichTextLabel


#Block Cipher
enum Type {NA, Init, Key, Text};
@export var _type: Type;


var _lastMousePos: Vector2;
var _isDragging: bool = false;
var startPos: Vector2

var _data: String;


func  _ready() -> void:
	assert(_rayCenter != null, name + "'s raycast is null");
	
	startPos = $DefaultPosition.global_position + ($DefaultPosition.size - size)/2;
	_rayCenter.global_position = Vector2(global_position.x + size.x/2, global_position.y + size.y/2);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _isDragging:
		var newMousePos = get_viewport().get_mouse_position();
		position += (newMousePos-_lastMousePos);
		_lastMousePos = newMousePos;
	


func _on_button_down() -> void:
	#don't allow moving the dragables after loading win level screen 
	if Global._winState:
		return;
	GlobalSounds.click.play()
	_lastMousePos = get_viewport().get_mouse_position();
	_isDragging = true;
	updateSize()
	if _rayCenter.is_colliding():
		var collider = _rayCenter.get_collider()
		collider.depopulate()


func _on_button_up() -> void:
	GlobalSounds.drop.play()
	_isDragging = false;
	var collide = false
	var _currentMousePos = get_viewport().get_mouse_position();
	if _rayCenter.is_colliding(): #move to center of drop in box
		var colliderParent = _rayCenter.get_collider().get_parent();
		
		var collider = _rayCenter.get_collider()
		if collider.checkAndFill(self):
			collide = true
		global_position = colliderParent.global_position + (colliderParent.size - size)/2;
	
	if not collide:
		resetPosition()
	
	_isDragging = false;
	
func resetPosition():
	self.global_position = startPos
	
	#also reset the dynamic sizing of the node
	updateSize()

func updateSize():
	resizeText()
	self.size = textNode.size
	_rayCenter.global_position = Vector2(global_position.x + size.x/2, global_position.y + size.y/2);

func resizeText():
	var length = textNode.text.length()
	if length <= 12:
		changeFontSize(textNode, 14)
	elif length > 12 && length <= 56:
		changeFontSize(textNode, 12)
	elif length > 56 && length <= 90:
		changeFontSize(textNode, 10)
	elif length > 90 && length <= 132:
		changeFontSize(textNode, 8)
	elif length > 132:
		changeFontSize(textNode, 10)

func changeFontSize(textNode, size):
	if(textNode.text.length() <= 132):
		textNode.fit_content = true
		textNode.set_custom_minimum_size(Vector2(210, 0))
		textNode.size.y = 0
	else:
		textNode.fit_content = false
		textNode.set_custom_minimum_size(Vector2(210, 75))
		
	textNode.add_theme_font_size_override("normal_font_size", size)

func changeNodeSize(container):
	self.size.y = container.size.y
	_rayCenter.global_position = Vector2(global_position.x + size.x/2, global_position.y + size.y/2);

func changeTextNodeSize(containerSize):
	if containerSize.size.y < 70:
		textNode.fit_content = false
		textNode.set_custom_minimum_size(Vector2(210, containerSize.size.y))
	else:
		textNode.fit_content = true
		textNode.set_custom_minimum_size(Vector2(210, 0))
		textNode.size.y = 0
	changeNodeSize(containerSize)
	
func _on_text_theme_changed() -> void:
	var dragText = $CenterContainer/text

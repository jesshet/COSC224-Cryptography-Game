extends Node2D

@export var _parentOfLevel: Node;
@export var _currentLevel: Node;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.game_scene == null:
		Global.game_scene = self;
	else:
		queue_free()
		pass;
	if _parentOfLevel == null:
		printerr("Level Select Parent is null");
	
func _load_new_level(level: PackedScene) -> void:
	if level == null:
		return;
	if _currentLevel != null:
		var list: PackedStringArray = level._bundled.get("names");
		print(list[0] + "," + _currentLevel.name);
		if list[0] == _currentLevel.name:
			return;
		_currentLevel.queue_free();
	
	_currentLevel = level.instantiate();
	_parentOfLevel.add_child(_currentLevel);

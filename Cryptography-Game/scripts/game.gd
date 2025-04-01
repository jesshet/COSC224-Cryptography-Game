extends Node2D

@export var _parentOfLevel: Node;
@export var _currentLevel: Node;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_child(GlobalSounds.music)
	self.add_child(GlobalSounds.hover)
	self.add_child(GlobalSounds.select)
	self.add_child(GlobalSounds.load)
	self.add_child(GlobalSounds.close)
	self.add_child(GlobalSounds.click)
	self.add_child(GlobalSounds.drop)
	GlobalSounds.music.play()
	Global.bg = $"Background/sphere-bg/SubViewport/sphere-bg"
	if Global.game_scene == null:
		Global.game_scene = self;
	else:
		queue_free()
		pass;
	assert(_parentOfLevel != null, "game.gd parent of level is null");
	
func _load_new_level(level: PackedScene, anim: String) -> void:
	if level == null:
		return;
	if _currentLevel != null:
		var list: PackedStringArray = level._bundled.get("names");
		#print(list[0] + "," + _currentLevel.name);
		if list[0] == _currentLevel.name:
			return;
		_currentLevel.queue_free();
	
	Global.bg.playAnimation(anim)
	
	if Global.bg.prevAnim == anim:
		await get_tree().create_timer(1.0).timeout
	else:
		await get_tree().create_timer(2.0).timeout
	
	_currentLevel = level.instantiate();
	_parentOfLevel.add_child(_currentLevel);

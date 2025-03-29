extends GutTest

var _gameScene = preload("res://scenes/game.tscn");
var _level = preload("res://scenes/stream-level.tscn");
var _gameNode:Node;


func before_each() -> void:
	_gameNode = _gameScene.instantiate();
	add_child(_gameNode);
	await get_tree().process_frame;
	assert_eq(_gameNode.name, "game");
	Global.game_scene._load_new_level(_level);
	await get_tree().process_frame;
	pass;
	
func after_each() -> void:
	_gameNode.queue_free();
	
	

#Test Case 20: Did the level load?
func test_level_loaded() -> void:
	assert_true(Global.game_scene._currentLevel != null); 
	assert_eq(Global.game_scene._currentLevel.name, "StreamLevel"); 
	pass;

#Test Case 21: Did the level reload it's self?
func test_level_reloaded_same() -> void:
	var id = Global.game_scene._currentLevel.get_instance_id();
	Global.game_scene._load_new_level(_level);
	await get_tree().process_frame;
	assert_eq(Global.game_scene._currentLevel.name, "StreamLevel");
	var id2 = Global.game_scene._currentLevel.get_instance_id();
	assert_eq(id2,id);
	pass;
	

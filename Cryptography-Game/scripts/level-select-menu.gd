extends Container

var _root: Node;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_root = get_tree().get_root();


func _on_level_load_level(level: PackedScene) -> void:
	if level == null:
		print("Level was null");
		return;
	print(level.resource_path);
	var newLevel = level.instantiate();
	_root.add_child(newLevel);
	queue_free();

func _on_close_button_pressed() -> void:
	queue_free()

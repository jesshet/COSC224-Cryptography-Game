extends HBoxContainer
var game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = get_tree().get_root()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_settings_pressed() -> void:
	var settings = preload("res://scenes/settings-menu.tscn").instantiate()
	print("settings clicked")
	game.add_child(settings)
	print("after settings node")


func _on_codex_pressed() -> void:
	var codex = preload("res://scenes/codex.tscn").instantiate()
	print("codex clicked")
	game.add_child(codex)
	print("after codex node")


func _on_exit_pressed() -> void:
	get_tree().quit()

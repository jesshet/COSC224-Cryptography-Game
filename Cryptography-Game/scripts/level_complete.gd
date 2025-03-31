extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("open-window")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_codex_btn_pressed() -> void:
	var codex = preload("res://scenes/codex.tscn").instantiate()
	get_tree().get_root().add_child(codex)


func _on_level_select_btn_pressed() -> void:
	var levelSelect = load("res://scenes/level-select-menu.tscn").instantiate()
	get_tree().get_root().add_child(levelSelect)

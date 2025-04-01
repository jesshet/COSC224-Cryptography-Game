extends Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSounds.success.play()
	GlobalSounds.musicVol = GlobalSounds.music.get_volume_db();
	GlobalSounds.music.set_volume_db(-200)
	$AnimationPlayer.play("open-window")
	await get_tree().create_timer(3).timeout
	GlobalSounds._fade_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_codex_btn_pressed() -> void:
	GlobalSounds.select.play()
	var codex = preload("res://scenes/codex.tscn").instantiate()
	get_tree().get_root().add_child(codex)


func _on_level_select_btn_pressed() -> void:
	GlobalSounds.select.play()
	var levelSelect = load("res://scenes/level-select-menu.tscn").instantiate()
	get_tree().get_root().add_child(levelSelect)


func _on_codex_btn_mouse_entered() -> void:
	GlobalSounds.hover.play()


func _on_level_select_btn_mouse_entered() -> void:
	GlobalSounds.hover.play()

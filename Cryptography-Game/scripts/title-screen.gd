extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_button_pressed() -> void:
	GlobalSounds.select.play()
	get_tree().get_root().add_child(preload("res://scenes/level-select-menu.tscn").instantiate())
	queue_free()

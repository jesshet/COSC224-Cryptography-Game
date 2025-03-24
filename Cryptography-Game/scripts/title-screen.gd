extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_button_pressed() -> void:
	get_tree().get_root().add_child(preload("res://scenes/level-select-menu.tscn").instantiate())
	queue_free()

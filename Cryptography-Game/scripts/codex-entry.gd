extends Button

@onready var textBox: RichTextLabel = $"../CodexEntry"

func _ready() -> void:
	pass

func _on_pressed() -> void:
	textBox.visible = !textBox.visible

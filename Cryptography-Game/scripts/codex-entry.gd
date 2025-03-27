extends TextureButton

@export var title : String 
@export_multiline var body : String

func _ready() -> void:
	$"Button-title".text = title

func _pressed() -> void:
	var codex = get_parent().get_parent().get_parent()
	codex.setTitle(title)
	codex.setBody(body)

extends Control

@onready var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var music_bus = AudioServer.get_bus_index("Music")

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))


func _on_mute_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(sfx_bus, toggled_on)
	AudioServer.set_bus_mute(music_bus, toggled_on)

func _on_close_button_pressed() -> void:
	pass

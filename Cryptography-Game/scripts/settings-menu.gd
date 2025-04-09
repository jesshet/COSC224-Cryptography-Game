extends Control

@export var _sfx_slider:HSlider;
@export var _music_slider:HSlider;
@export var _mute_toggle:CheckButton;

@onready var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var music_bus = AudioServer.get_bus_index("Music")

func _ready() -> void:
	Global.menuOpen = true
	$AnimationPlayer.play("open-window")
	
	if _music_slider == null or _sfx_slider == null or _mute_toggle == null:
		print("One of the fields is null in the Settings Menu");
		return;
	
	var sfx_vol = AudioServer.get_bus_volume_db(sfx_bus);
	var music_vol = AudioServer.get_bus_volume_db(music_bus);
	var	mute_toggle = AudioServer.is_bus_mute(0);
	_sfx_slider.value = sfx_vol;
	_music_slider.value = music_vol;
	_mute_toggle.button_pressed = mute_toggle;
	pass;

func _on_sfx_slider_value_changed(value: float) -> void:
	if(value == -40):
		AudioServer.set_bus_volume_db(sfx_bus, -200)
	else:
		AudioServer.set_bus_volume_db(sfx_bus, value)


func _on_music_slider_value_changed(value: float) -> void:
	if(value == -40):
		AudioServer.set_bus_volume_db(music_bus, -200)
	else:
		AudioServer.set_bus_volume_db(music_bus, value)


func _on_mute_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)

func _on_close_button_pressed() -> void:
	Global.menuOpen = false
	GlobalSounds.close.play()
	$AnimationPlayer.play("close-window")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close-window":
		queue_free()


func _on_close_button_mouse_entered() -> void:
	GlobalSounds.hover.play()

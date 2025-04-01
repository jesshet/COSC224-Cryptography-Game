extends Node

var hover: AudioStreamPlayer = AudioStreamPlayer.new()
var select: AudioStreamPlayer = AudioStreamPlayer.new()
var load: AudioStreamPlayer = AudioStreamPlayer.new()
var close: AudioStreamPlayer = AudioStreamPlayer.new()
var music: AudioStreamPlayer = AudioStreamPlayer.new()
var drop: AudioStreamPlayer = AudioStreamPlayer.new()
var success: AudioStreamPlayer = AudioStreamPlayer.new()
var click: AudioStreamPlayer = AudioStreamPlayer.new()

var musicVol
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var clickStream: AudioStream = preload("res://assets/sounds/click.wav")
	click.set_stream(clickStream)
	click.set_bus("SFX")
	click.set_volume_db(-15)
	
	var dropStream: AudioStream = preload("res://assets/sounds/drop.wav")
	drop.set_stream(dropStream)
	drop.set_bus("SFX")
	drop.set_volume_db(-10)
	
	var hoverStream: AudioStream = preload("res://assets/sounds/hover.wav")
	hover.set_stream(hoverStream)
	hover.set_bus("SFX")
	hover.set_volume_db(-20)
	
	
	var selectStream: AudioStream = preload("res://assets/sounds/select.wav")
	select.set_stream(selectStream)
	select.set_bus("SFX")
	select.set_volume_db(-20)
	
	var loadStream: AudioStream = preload("res://assets/sounds/enter.mp3")
	load.set_stream(loadStream)
	load.set_bus("SFX")
	load.set_volume_db(-15)
	
	var closeStream: AudioStream = preload("res://assets/sounds/close.mp3")
	close.set_stream(closeStream)
	close.set_bus("SFX")
	close.set_volume_db(-25)
	
	var musicStream: AudioStream = preload("res://assets/music/Soundtrack.mp3")
	music.set_stream(musicStream)
	music.set_bus("Music")
	music.set_volume_db(-20)
	music.autoplay = true
	
	
func _fade_music() -> void:
	while(GlobalSounds.music.get_volume_db() < GlobalSounds.musicVol):
		await get_tree().create_timer(.01).timeout
		GlobalSounds.music.set_volume_db(GlobalSounds.music.get_volume_db() + 1)
		print(GlobalSounds.music.get_volume_db())

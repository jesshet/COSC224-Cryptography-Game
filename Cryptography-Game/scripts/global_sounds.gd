extends Node

#Instantiate Global AudioStreamPlayers
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
	
	#Audio Player for Text Clicking Sound Effect
	var clickStream: AudioStream = preload("res://assets/sounds/click.wav")
	click.set_stream(clickStream)
	#Change This Value to set Audio Bus
	click.set_bus("SFX")
	#Change This Value to set Volume
	click.set_volume_db(-15)
	
	#Audio Player for Draggable Dropping Sound Effect
	var dropStream: AudioStream = preload("res://assets/sounds/drop.wav")
	drop.set_stream(dropStream)
	#Change This Value to set Audio Bus
	drop.set_bus("SFX")
	#Change This Value to set Volume
	drop.set_volume_db(-10)
	
	#Audio Player for Button Hovering Sound Effect
	var hoverStream: AudioStream = preload("res://assets/sounds/hover.wav")
	hover.set_stream(hoverStream)
	#Change This Value to set Audio Bus
	hover.set_bus("SFX")
	#Change This Value to set Volume
	hover.set_volume_db(-20)
	
	#Audio Player for Menu Select Sound Effect
	var selectStream: AudioStream = preload("res://assets/sounds/select.wav")
	select.set_stream(selectStream)
	#Change This Value to set Audio Bus
	select.set_bus("SFX")
	#Change This Value to set Volume
	select.set_volume_db(-25)
	
	#Audio Player for Level Load Sound Effect
	var loadStream: AudioStream = preload("res://assets/sounds/enter.mp3")
	load.set_stream(loadStream)
	#Change This Value to set Audio Bus
	load.set_bus("SFX")
	#Change This Value to set Volume
	load.set_volume_db(-15)
	
	#Audio Player for Window Closing Sound Effect
	var closeStream: AudioStream = preload("res://assets/sounds/close.mp3")
	close.set_stream(closeStream)
	#Change This Value to set Audio Bus
	close.set_bus("SFX")
	#Change This Value to set Volume
	close.set_volume_db(-25)
	
	#Audio Player for Background Music
	var musicStream: AudioStream = preload("res://assets/music/Soundtrack.mp3")
	music.set_stream(musicStream)
	#Change This Value to set Audio Bus
	music.set_bus("Music")
	#Change This Value to set Music Volume
	music.set_volume_db(-20)
	#Sets Music to autoplay and game load
	music.autoplay = true
	
	
func _fade_music() -> void:
	#Fades Music Volume from -200db back to current volume setting
	while(GlobalSounds.music.get_volume_db() < GlobalSounds.musicVol):
		#Change this value to set fade speed
		await get_tree().create_timer(.01).timeout
		#Change this value to set volume step
		GlobalSounds.music.set_volume_db(GlobalSounds.music.get_volume_db() + 1)

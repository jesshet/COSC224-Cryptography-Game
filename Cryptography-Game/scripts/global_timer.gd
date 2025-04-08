extends Node

var _timer: float;
var _running: bool;
var _count: int;

		
	
#Using Physics Processing to keep the timer hardware independent
func _physics_process(delta: float) -> void:
	if _running:
		_timer += delta;
		_count += 1
		if(_count % 60 == 0):
			GlobalSounds.tick.play()

func _reset_timer() -> void:
	_running = false;
	_timer = 0;
	pass;
	
func _time_text() -> String:
	var timerInSec = int(GlobalTimer._timer);
	var second:int = timerInSec % 60;
	var minute:int = timerInSec / 60;
	if(second < 10 && minute < 10):
		return ("0%-1.0f:0%-1.0f" % [minute, second]);
	elif(second < 10):
		return ("%-1.0f:0%-1.0f" % [minute, second]);
	elif(minute < 10):
		return ("0%-1.0f:%-1.0f" % [minute, second]);
	else:
		return ("%-1.0f:%-1.0f" % [minute, second]);

func _start_timer() -> void:
	_running = true;
	pass;
	
func _stop_timer() -> void:
	_running = false;
	pass;
	

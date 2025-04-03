extends Node

var _timer: float;
var _running: bool;

func _process(delta: float) -> void:
	if _running:
		_timer += delta;
	pass;

func _reset_timer() -> void:
	_running = false;
	_timer = 0;
	pass;
	
func _time_text() -> String:
	var timerInSec = int(GlobalTimer._timer);
	var second:int = timerInSec % 60;
	var minute:float = timerInSec / 60;
	return ("%2.0f : %2.0f" % [minute, second]);

func _start_timer() -> void:
	_running = true;
	pass;
	
func _stop_timer() -> void:
	_running = false;
	pass;
	

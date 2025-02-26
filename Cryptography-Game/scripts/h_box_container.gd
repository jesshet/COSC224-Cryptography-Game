extends HBoxContainer

var shift = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass # Replace with function body.
	

func _on_left_pressed() -> void:
	$click.play();
	shift -= 1;
	$shift.text = "[center]" + str(shift % 26);

func _on_right_pressed() -> void:
	$click.play();
	shift += 1;
	$shift.text = "[center]" + str(shift % 26);

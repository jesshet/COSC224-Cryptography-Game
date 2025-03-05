extends HBoxContainer

signal left_pressed;
signal right_pressed;

var shift = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_left_pressed() -> void:
	left_pressed.emit();
	$click.play();
	shift -= 1;
	$shift.text = "[center]" + str((26 + shift) % 26);

func _on_right_pressed() -> void:
	right_pressed.emit();
	$click.play();
	shift += 1;
	$shift.text = "[center]" + str((26 + shift) % 26);
	
func shift_text(String: text, int: shift) -> String:
	#for(int i = 0; i < text.length(); i++){
	return text;

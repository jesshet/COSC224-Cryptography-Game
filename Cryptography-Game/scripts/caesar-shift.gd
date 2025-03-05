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
	

func _on_left_pressed():
	$click.play();
	shift = (shift - 1) % 26;
	$shift.text = "[center]" + str((26 + shift) % 26);
	left_pressed.emit();
	return shift;

func _on_right_pressed():
	
	$click.play();
	shift = (shift + 1) % 26;
	$shift.text = "[center]" + str((26 + shift) % 26);
	right_pressed.emit();
	return shift;
	
func get_shift():
	return shift;
	
func shift_left(text):
	#Convert to ASCII array for shifting
	var letters = text.to_upper().to_ascii_buffer();
	for i in range(letters.size()):
		var n = letters[i];
		
		#Ignore Spaces
		if(n != 32):
			print(n);
			if(n == 65):
				n += 26;
			#Shifting Logic
			letters[i] = ((n - 65 - 1) % 26) + 65;
	#Revert Back to string
	text = letters.get_string_from_ascii();
	print(text);
	#Add Center Alignment and return
	return "[center]" + text;
	
func shift_right(text):
	#Convert to ASCII array for shifting
	var letters = text.to_upper().to_ascii_buffer();
	for i in range(letters.size()):
		var n = letters[i];
		
		#Ignore Spaces
		if(n != 32):
			#Shifting Logic
			letters[i] = ((n - 65 + 1) % 26) + 65;
			print(letters[i]);
	#Revert Back to string
	text = letters.get_string_from_ascii();
	print(text);
	#Add Center Alignment and return
	return "[center]" + text;

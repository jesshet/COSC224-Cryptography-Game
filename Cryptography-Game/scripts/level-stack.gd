extends VBoxContainer
var Caesar;
var Solution;
var Message;
var guesses;
var Problem;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_parent().get_parent().get_parent().get_parent().get_class())
	#Guess Tracker Variable
	guesses = 0;
	
	#Answer Text
	Solution = "[center]MEET ME AT THE RIVER AT FIVE PM SHARP";
	
	#Store Problem Text for Printing
	Problem = $Problem.text.substr(8, -1);
	$Problem.text = "[center]";
	
	#Store Message Text for Printing
	Message = $Message.text.substr(8, -1);
	$Message.text = "[center]";
	
	#Disable Mouse Clicking While Text Prints
	$Caesar/Button.disabled = true;
	$Caesar/HBoxContainer/left.disabled = true;
	$Caesar/HBoxContainer/right.disabled = true;
	
	#Loop To Print Text
	for i in range(Message.length()):
		$Clicks.play();
		$Message.text = $Message.text + Message[i];
		if(Message[i] == "."):
			await get_tree().create_timer(0.3).timeout
		else:
			await get_tree().create_timer(0.04).timeout
		
		
	for i in range(Problem.length()):
		$Clicks.play();
		$Problem.text = $Problem.text + Problem[i];
		if(Problem[i] == "."):
			await get_tree().create_timer(0.3).timeout
		else:
			await get_tree().create_timer(0.04).timeout
		
	#Enable Mouse Clicking
	$Caesar/Button.disabled = false;
	$Caesar/HBoxContainer/left.disabled = false;
	$Caesar/HBoxContainer/right.disabled = false;
	
	#Connect Caesar Scene Signals
	connect_caesar();

func connect_caesar() -> void:
	#Connect Caesar Node
	Caesar = get_node("Caesar/HBoxContainer");
	
	#Connect Submit Button Signal
	Caesar.submit.connect(_on_h_box_container_button_pressed);
	
	#Connect Left and Right Shift Signals
	Caesar.left_pressed.connect(_on_h_box_container_left_pressed);
	Caesar.right_pressed.connect(_on_h_box_container_right_pressed);


func _on_h_box_container_left_pressed() -> void:
	#Get Current Caesar Shift Amount
	var n = Caesar.get_shift();
	#Substring to retain "[center]" format string
	$Problem.text = Caesar.shift_left($Problem.text.substr(8, -1));
	#Turn Text Cyan
	$Message.text = "[center][color=00dcea]" + Message;



func _on_h_box_container_right_pressed() -> void:
	#Get Current Caesar Shift Amount
	var n = Caesar.get_shift();
	#Substring to retain "[center]" format string
	$Problem.text = Caesar.shift_right($Problem.text.substr(8, -1));
	#Turn Text Cyan
	$Message.text = "[center][color=00dcea]" + Message;


func _on_child_order_changed() -> void:
	if(get_node_or_null("Caesar")):
		connect_caesar();


func _on_h_box_container_button_pressed() -> void:
	if($Problem.text == Solution):
		#Turn Text Green
		$Message.text = "[center][color=4BB543]Success!\n\n\n";
		#Play Success Sound
		Caesar.success();
	else:
		#Turn Text Red
		$Message.text = "[center][color=ff0000]Incorrect\n\n\n";
		#Play Incorrect Sound
		Caesar.incorrect();
		#Increment Guess Counter
		guesses = guesses + 1;
	
	if(guesses == 2):
		pass

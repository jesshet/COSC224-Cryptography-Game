extends VBoxContainer
var Caesar;
var Solution;
var Message;
var guesses;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	guesses = 0;
	Solution = "[center]ATTACK AT DAWN";
	Message = $Message.text;
	#for i in range($Message.text.length()):
		#$Message.text += Message.text[i];
	connect_caesar();
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
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
		$Message.text = "[center][color=4BB543]Success!";
		#Play Success Sound
		Caesar.success();
	else:
		#Turn Text Red
		$Message.text = "[center][color=ff0000]Incorrect";
		#Play Incorrect Sound
		Caesar.incorrect();
		#Increment Guess Counter
		guesses = guesses + 1;
	
	if(guesses == 2):
		pass

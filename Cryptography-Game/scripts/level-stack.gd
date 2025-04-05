extends Control
var Caesar;
var Solution;
var Message;
var guesses;
var Problem;
var windowsOpen;

@export_category("Level Messages")
@export_multiline var levelMessages : Array[String];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Guess Tracker Variable
	guesses = 0;
	
	Global.caesarOpen = true
	#windows start closed
	windowsOpen = false
	
	#Answer Text
	Solution = "MEET ME AT THE RIVER AT FIVE PM SHARP";
	
	#Send the Levels messages to the messagePlayer
	playMessage()
	
	#Connect Caesar Scene Signals
	connect_caesar();
	

func connect_caesar() -> void:
	#Connect Caesar Node
	Caesar = get_node("Caesar/HBoxContainer");
	
	#Connect MessagePlayer
	$MessagePlayer.message_complete.connect(_on_message_complete);
	
	#Connect Left and Right Shift Signals
	Caesar.left_pressed.connect(_on_h_box_container_left_pressed);
	Caesar.right_pressed.connect(_on_h_box_container_right_pressed);


func _on_h_box_container_left_pressed() -> void:
	#Get Current Caesar Shift Amount
	var n = Caesar.get_shift();
	#Substring to retain "[center]" format string
	$Problem.text = Caesar.shift_left($Problem.text);
	#Turn Text Cyan
	#$Message.text = "[center][color=00dcea]" + Message;



func _on_h_box_container_right_pressed() -> void:
	#Get Current Caesar Shift Amount
	var n = Caesar.get_shift();
	#Substring to retain "[center]" format string
	$Problem.text = Caesar.shift_right($Problem.text);
	#Turn Text Cyan
	#$Message.text = "[center][color=00dcea]" + Message;


func _on_child_order_changed() -> void:
	if(get_node_or_null("Caesar")):
		connect_caesar();

func _on_submit_button_pressed() -> void:
	print(guesses)
	if($Problem.text == Solution):
		Global.caesarComplete = true
		#Play Success Sound
		var winScreen = preload("res://scenes/level-complete.tscn").instantiate()
		add_child(winScreen)
	else:
		#Play Incorrect Sound
		Caesar.incorrect();
		#Increment Guess Counter
		guesses = guesses + 1;
	
	if(guesses == 3 && $Problem.text != Solution):
		$MessagePlayer.startMessage("This is a placeholder for the hint text.")
		#put code here to make a button that replays the hint
		
func _on_message_complete() -> void:
	if !windowsOpen:
		$"../../AnimationPlayer".play("Open-windows")
		windowsOpen = true

func playMessage():
	$MessagePlayer.startMessages(levelMessages);

func _on_replay_pressed() -> void:
	$MessagePlayer.messageIndex = 0
	playMessage()


func _on_submit_button_mouse_entered() -> void:
	GlobalSounds.hover.play()


func _on_replay_mouse_entered() -> void:
	GlobalSounds.hover.play()

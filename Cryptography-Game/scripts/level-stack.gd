extends VBoxContainer
var Caesar;
var Solution;
var Message;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Solution = "[center]ATTACK AT DAWN";
	Message = $Message.text;
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
	var n = Caesar.get_shift();
	$Problem.text = Caesar.shift_left($Problem.text.substr(8, -1));
	$Message.text = Message;


func _on_h_box_container_right_pressed() -> void:
	var n = Caesar.get_shift();
	$Problem.text = Caesar.shift_right($Problem.text.substr(8, -1));
	$Message.text = Message;


func _on_child_order_changed() -> void:
	if(get_node_or_null("Caesar")):
		connect_caesar();


func _on_h_box_container_button_pressed() -> void:
	if($Problem.text == Solution):
		$Message.text = "[center]Success!";
		Caesar.success();
	else:
		$Message.text = "[center]Incorrect";
		Caesar.incorrect();

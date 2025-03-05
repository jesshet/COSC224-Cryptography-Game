extends VBoxContainer
var Caesar;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_caesar();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func connect_caesar() -> void:
	Caesar = get_node("Caesar/HBoxContainer");
	Caesar.left_pressed.connect(_on_h_box_container_left_pressed);
	Caesar.right_pressed.connect(_on_h_box_container_right_pressed);


func _on_h_box_container_left_pressed() -> void:
	var n = Caesar.get_shift();
	print("Shift amount: " + str(n));
	$Problem.text = Caesar.shift_left($Problem.text.substr(8, -1));
	print("Left");


func _on_h_box_container_right_pressed() -> void:
	var n = Caesar.get_shift();
	print("Shift amount: " + str(n));
	$Problem.text = Caesar.shift_right($Problem.text.substr(8, -1));
	print("Right");


func _on_child_order_changed() -> void:
	if(get_node_or_null("Caesar")):
		connect_caesar();

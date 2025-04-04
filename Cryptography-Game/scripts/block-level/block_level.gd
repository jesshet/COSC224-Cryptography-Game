extends Control
@export_multiline var levelMessages : Array[String];

@export var _key: Button;
@export var _initialization: Button;
@export var _text: Button;

@export var _level: Control;

var _winScreen = preload("res://scenes/level-complete.tscn");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(_level._answer.length() > 0, "Answer is empty");
	assert(_key != null, "Key Dragable is null");
	assert(_initialization != null, "Initialization Dragable is null");
	assert(_text != null, "Text Dragable is null");
	
	display_dragables(false);
	
	#create answer
	_text.text = _level._plainText;
	var hexPlainText = GlobalAlgorithms.text_to_hex(_level._plainText);
	var key = GlobalAlgorithms.generate_hex_key(hexPlainText);
	_key.text = key;
	var init = GlobalAlgorithms.text_to_hex(_level._initStr);
	_initialization.text = init;
	var xorafter = GlobalAlgorithms.xor(hexPlainText,init);
	_level._answer = GlobalAlgorithms.xor(xorafter,key);
	
	playMessage()
	$DraggableContainerFrame/AnimationPlayer.play("open-window")
	await get_tree().create_timer(0.3).timeout
	
	display_dragables(true);
	pass;

func display_dragables(state: bool) -> void:
	_key.set_visible(state);
	_initialization.set_visible(state);
	_text.set_visible(state);
	pass;
	
func playMessage():
	$LevelStack/MessagePlayer.startMessages(levelMessages)
	
#win state
func _on_submitbox_submit() -> void:
	var text = $"submit-box/TextEdit".text.to_lower();
	if(_level._answer.to_lower() == text):
		GlobalTimer._stop_timer();
		var winScreen = _winScreen.instantiate();
		$LevelStack.add_child(winScreen);

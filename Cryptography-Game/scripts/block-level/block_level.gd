extends Control
@export_multiline var levelMessages : Array[String];

@export var _key: TextureButton;
@export var _initialization: TextureButton;
@export var _text: TextureButton;

@export var _plainText: String;
@export var _initStr: String;

var _answer: String = "Error: Not Set";


var _winScreen = preload("res://scenes/level-complete.tscn");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.blockOpen = true
	assert(_plainText.length() > 0, "PlainText is empty");
	assert(_key != null, "Key Dragable is null");
	assert(_initialization != null, "Initialization Dragable is null");
	assert(_text != null, "Text Dragable is null");
	
	display_dragables(false);
	
	#create answer
	_text.textNode.text = _plainText;
	var hexPlainText = GlobalAlgorithms.text_to_hex(_plainText);
	var key = GlobalAlgorithms.generate_hex_key(hexPlainText);
	_key.textNode.text = key;
	var init = GlobalAlgorithms.text_to_hex(_initStr);
	_initialization.textNode.text = init;
	var xorafter = GlobalAlgorithms.xor(hexPlainText,init);
	_answer = GlobalAlgorithms.xor(xorafter,key).to_upper();
	
	#visuals
	playMessage()
	pass;

func display_dragables(state: bool) -> void:
	_key.set_visible(state);
	_initialization.set_visible(state);
	_text.set_visible(state);
	set_visible(state);
	pass;
	
# startup visuals
func playMessage():
	$LevelStack/MessagePlayer.startMessages(levelMessages)
	$DraggableContainerFrame/AnimationPlayer.play("open-window")
	await get_tree().create_timer(0.3).timeout
	display_dragables(true);
	
	
func _on_repeat_text_pressed() -> void:
	playMessage()
	
#win state
func _on_submitbox_submit() -> void:
	var text = $"submit-box/LineEdit".text.to_upper();
	if(_answer == text):
		Global.blockComplete = true
		GlobalTimer._stop_timer();
		var winScreen = _winScreen.instantiate();
		$LevelStack.add_child(winScreen);

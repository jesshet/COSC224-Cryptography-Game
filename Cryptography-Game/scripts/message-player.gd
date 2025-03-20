extends Control

var messages;
var currentMessage;
var label;
var count;

var waitingForInput;
var isOpen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = $Message;
	label.text = "";
	currentMessage = 0;
	count = 0
	isOpen = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func startMessages() -> void:
	$MessageAnimations.play("open-windows")

func printMessages(currentMessage) -> void:
	label.text = messages[currentMessage];
	count = 0
	label.visible_characters = count;
	#Loop To Print Text
	while(label.visible_characters < messages[currentMessage].length()):
		#$Clicks.play();
		count = count + 1
		label.visible_characters = count
		if(messages[currentMessage][count - 1] == "."):
			await get_tree().create_timer(0.3).timeout
		else:
			await get_tree().create_timer(0.02).timeout
	
	print("Finished Message")		
	count = 0
	waitingForInput = true;


func _input(ev) -> void:
	if ev is InputEventMouseButton && ev.is_pressed() && count < messages[currentMessage].length() - 1:
		count = messages[currentMessage].length() - 1
		return
		
	if ev is InputEventMouseButton && ev.is_pressed() && waitingForInput:
		if currentMessage < messages.size() - 1:
			currentMessage = currentMessage + 1
			printMessages(currentMessage)
		elif currentMessage >= messages.size() - 1 && isOpen:
			$MessageAnimations.play("close-windows")
			isOpen = false


func _on_message_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open-windows":
		isOpen = true
		printMessages(currentMessage)
		

func setMessage(messageArray) -> void:
	messages = messageArray

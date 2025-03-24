extends CanvasLayer

var messages: Array[String]
var currentMessage: String
var isArray: bool
var waitingForInput: bool
var isOpen: bool

var messageIndex: int
var count: int

var label
signal message_complete


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = $Message
	messageIndex = 0
	count = 0
	isOpen = false

func startMessages(messages : Array[String]) -> void:
	isArray  = true
	self.messages = messages
	messageIndex = 0
	label.visible_characters = 0
	$MessageAnimations.play("open-windows")
	
func startMessage(message : String) -> void:
	isArray = false
	messages.clear()
	messageIndex = 1
	currentMessage = message
	label.visible_characters = 0
	$MessageAnimations.play("open-windows")

func printMessages(messageIndex) -> void:
	if isArray:
		currentMessage = messages[messageIndex]
	count = 0
	label.visible_characters = count
	label.text = currentMessage
	print(messages.size())
	#Loop To Print Text
	while(label.visible_characters < currentMessage.length()):
		#$Clicks.play();
		count += 1
		label.visible_characters = count
		if(currentMessage[count - 1] == "."):
			await get_tree().create_timer(0.3).timeout
		else:
			await get_tree().create_timer(0.02).timeout
			
	waitingForInput = true;


func _input(ev) -> void:
	if ev is InputEventMouseButton && ev.is_pressed() && count < currentMessage.length() - 1:
		count = currentMessage.length() - 1
		return
		
	if ev is InputEventMouseButton && ev.is_pressed() && waitingForInput:
		
		if messageIndex < messages.size() - 1:
			messageIndex += 1
			printMessages(messageIndex)
			
		elif messageIndex >= messages.size() - 1 && isOpen:
			$MessageAnimations.play("close-windows")
			isOpen = false


func _on_message_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open-windows":
		isOpen = true
		printMessages(messageIndex)
	if anim_name == "close-windows":
		message_complete.emit();
		

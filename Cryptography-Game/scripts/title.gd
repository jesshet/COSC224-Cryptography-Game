extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	decryptEffect()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func decryptEffect(): 
	var RNG = RandomNumberGenerator.new()
	var randomLetter;
	var changeAmount
	var randomWait;
	while(true):
		randomLetter = RNG.randi_range(8, self.text.length() - 1)
		changeAmount = RNG.randi_range(10, 25)
		randomWait = RNG.randi_range(1,5)
		
		var tempchar = self.text[randomLetter]
		
		for n in changeAmount:
			self.text[randomLetter] = get_random_char()
			await get_tree().create_timer(0.05).timeout
			
		self.text[randomLetter] = tempchar
		await get_tree().create_timer(randomWait).timeout



func get_random_char():
	var random_number = randi() % 26
	var characters = 'abcdefghijklmnopqrstuvwxyz'
	return characters[random_number]

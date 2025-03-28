extends Label

var currentWord = "è~X9"
var targetWord = "C3A87E5839"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var loop = 0
	var count = 0
	while(currentWord != targetWord):
		while(count < targetWord.length()):
			
			if count < currentWord.length() - 1:
				currentWord[count] = get_random_char()
			
			if count >= currentWord.length():
				currentWord += get_random_char()
				break
				
			if count == targetWord.length() - 1 && currentWord.length() > targetWord.length():
				currentWord = currentWord.left(currentWord.length() - 1)
				break
				
			if currentWord.length() == targetWord.length():
				currentWord[count] = targetWord[count]
				
			count += 1
			await get_tree().create_timer(0.01).timeout
			self.text = currentWord
		count = 0
		loop += 1
	
func get_random_char():
	var random_number = randi() % 26
	var characters = 'abcdefghijklmnopqrstuvwxyz'
	return characters[random_number]

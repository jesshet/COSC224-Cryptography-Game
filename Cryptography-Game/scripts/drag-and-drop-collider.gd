extends Area2D

var filled
var node
var textNode
var text
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	filled = false
	pass # Replace with function body.

func checkAndFill(s):
	if not filled:
		print("filling the collider")
		node = s
		textNode = s.get_child(0).get_child(0)
		s.changeTextNodeSize(self.get_parent())
		filled = true
		return true
	else:
		print("collider already filled")
		return false
		
func depopulate():
	print("depopulating the collider")
	filled = false

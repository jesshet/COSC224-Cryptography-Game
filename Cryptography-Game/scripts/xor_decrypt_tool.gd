extends Control
var _inputUpper
var _inputLower
var nodeUpper
var nodeLower
var filledUpper
var filledLower
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	filledUpper = false
	filledLower = false
	_inputUpper = ""
	_inputLower = ""
	pass # Replace with function body.


func depopulateUpper():
	filledUpper = false
func depopulateLower():
	filledLower = false

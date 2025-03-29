extends Node3D

var prevAnim : String
var camAnimations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prevAnim = ""
	camAnimations = $Camera_Animations


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func playAnimation(anim_name):
	if prevAnim == "":
		pass
	else:
		camAnimations.play_backwards(prevAnim)
		
	camAnimations.play(anim_name)
	prevAnim = anim_name

extends Node3D

var prevAnim : String
var camAnimations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prevAnim = "nothing"
	camAnimations = $Camera_Animations


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func isPlaying():
	return $Camera_Animations.is_playing()

func playAnimation(anim_name):
	if prevAnim == "nothing":
		pass
	else:
		camAnimations.play_backwards(prevAnim)
		await get_tree().create_timer(1.0).timeout
		
	camAnimations.play(anim_name)
	prevAnim = anim_name

extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	print("==> Game Started")

	# It changes to mouse capture mode
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

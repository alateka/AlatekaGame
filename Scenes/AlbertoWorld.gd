extends Spatial

func _ready():

	print("==> Game Started")

	# It changes to mouse capture mode
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# It modify game window 
	OS.set_window_size(Vector2(1280, 720))
	OS.center_window()

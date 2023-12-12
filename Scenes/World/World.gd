extends Node3D

@onready var WE = $WorldEnvironment

func _ready():
	# It changes to mouse capture mode
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print('==> Loaded level')

	# GPU settings
	WE.environment.ssao_enabled = true
	WE.environment.sdfgi_enabled = true

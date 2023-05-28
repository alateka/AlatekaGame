extends CharacterBody3D

# Variables
const SPEED: float = 7
const ACCELERATION: float = 9
const GRAVITY: float = 1.55
const JUMP_POWER: float = 59
const MOUSE_SENSIVILITY: float = 0.3
var xCameraRotate = 0

# Camera
@onready var head = $Head
@onready var camera = $Head/Camera

# Sounds
@onready var WalkSound = $WalkSound
@onready var JumpSound = $JumpSound

# Load to walk sound
func _ready():
	WalkSound.stream = preload('res://Assets/Sounds/WalkSound.ogg')
	JumpSound.stream = preload('res://Assets/Sounds/JumpSound.ogg')

# Camera Controller
func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSIVILITY))

		var xDelta = event.relative.y * MOUSE_SENSIVILITY

		if xCameraRotate + xDelta > -90 and xCameraRotate + xDelta < 90: 
			camera.rotate_x(deg_to_rad(-xDelta))
			xCameraRotate += xDelta

	if event is InputEvent and Input.is_action_just_pressed('escapeKey'):
		get_tree().change_scene_to_file('res://Scenes/MainMenu/MainMenu.tscn')


# Character Controller & Physics
func _physics_process(delta):
	var headTransform = head.get_global_transform().basis
	var direction = Vector3()
	var normalSpeed: float = SPEED
	var normalJump: float = JUMP_POWER

	# Play walk sound
	if velocity.x != 0 and is_on_floor():
		if !WalkSound.playing:
			WalkSound.play()
	elif WalkSound.playing:
		WalkSound.stop()

	# Run
	if Input.is_action_pressed('shiftKey'):
		normalSpeed = 15.0
		normalJump = 33.0
	else:
		normalSpeed = SPEED
		normalJump = JUMP_POWER

	# Jump and play jump sound
	if Input.is_action_just_pressed('spaceKey') and is_on_floor():
		direction.y = normalJump
		JumpSound.play()

	# Falling
	if not is_on_floor():
		direction.y -= GRAVITY + delta

	# Forward
	if Input.is_action_pressed('wKey'):
		direction -= headTransform.z
	# Back
	if Input.is_action_pressed('sKey'):
		direction += headTransform.z
	# Left
	if Input.is_action_pressed('aKey'):
		direction -= headTransform.x
	# Right
	if Input.is_action_pressed('dKey'):
		direction += headTransform.x
	
	velocity = velocity.lerp(direction * normalSpeed, ACCELERATION * delta)
	velocity.y -= GRAVITY
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	velocity = velocity

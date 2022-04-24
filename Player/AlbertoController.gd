extends KinematicBody

# Variables
const SPEED = 11
const ACCELERATION = 5
const GRAVITY = 1.11
const JUMP_POWER = 55
const MOUSE_SENSIVILITY = 0.3

onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()
var xCameraRotate = 0


# Camera Controller
func _input(event):

	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * MOUSE_SENSIVILITY))
		
		var xDelta = event.relative.y * MOUSE_SENSIVILITY
		
		if xCameraRotate + xDelta > -90 and xCameraRotate + xDelta < 90: 
			camera.rotate_x(deg2rad(-xDelta))
			xCameraRotate += xDelta


# Character Controller & Physics
func _physics_process(delta):
	
	var headTransform = head.get_global_transform().basis
	var direction = Vector3()

	if Input.is_action_just_pressed("spaceKey") and is_on_floor():
		direction.y = JUMP_POWER

	if not is_on_floor():
		direction.y -= GRAVITY + delta

	if Input.is_action_pressed("wKey"):
		direction -= headTransform.z

	if Input.is_action_pressed("sKey"):
		direction += headTransform.z

	if Input.is_action_pressed("aKey"):
		direction -= headTransform.x

	if Input.is_action_pressed("dKey"):
		direction += headTransform.x


	velocity = velocity.linear_interpolate(direction * SPEED, ACCELERATION * delta)
	velocity.y -= GRAVITY
	velocity = move_and_slide(velocity, Vector3.UP)

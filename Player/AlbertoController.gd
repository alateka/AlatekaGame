extends KinematicBody

# Variables
export var speed = 10
export var acceleration = 5
export var gravity = 0.99
export var jumpPower = 3
export var mouseSensivility = 0.3

onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()


func _ready():
	
	print("==> Game Started")
	
	# It changes to mouse capture mode
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Camera Controller
func _input(event):

	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouseSensivility))
		camera.rotate_x(deg2rad(-event.relative.y * mouseSensivility))


# Character Controller & Physics
func _process(delta):
	
	var headTransform = head.get_global_transform().basis
	var direction = Vector3()


	if not is_on_floor():
		direction.y -= gravity + delta

	if Input.is_action_pressed("wKey"):
		direction -= headTransform.z

	if Input.is_action_pressed("sKey"):
		direction += headTransform.z

	if Input.is_action_pressed("aKey"):
		direction -= headTransform.x

	if Input.is_action_pressed("dKey"):
		direction += headTransform.x

	if Input.is_action_pressed("spaceKey"):
		direction.y = jumpPower

	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity = move_and_slide(velocity)

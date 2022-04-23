extends KinematicBody

# Variables
export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jumpPower = 30
export var mouseSensivility = 0.3

onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()


# Camera Controller
func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouseSensivility))
		camera.rotate_x(deg2rad(-event.relative.y * mouseSensivility))


# Movement Controller
func _physics_process(delta):

	var headBasic = head.get_global_transform().basis
	var direction = Vector3()


	if Input.is_action_pressed("wKey"):
		direction -= headBasic.z

	if Input.is_action_pressed("sKey"):
		direction += headBasic.z

	if Input.is_action_pressed("aKey"):
		direction -= headBasic.x

	if Input.is_action_pressed("dKey"):
		direction += headBasic.x


	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity = move_and_slide(velocity)

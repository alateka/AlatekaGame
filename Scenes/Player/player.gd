extends CharacterBody3D

# Variables
const SPEED: float = 11
const ACCELERATION: float = 5
const GRAVITY: float = 1.11
const JUMP_POWER: float = 55
const MOUSE_SENSIVILITY: float = 0.3

@onready var head = $Head
@onready var camera = $Head/Camera

var xCameraRotate = 0


# Camera Controller
func _input(event):

	if event is InputEventMouseMotion:
		head.rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSIVILITY))
		
		var xDelta = event.relative.y * MOUSE_SENSIVILITY
		
		if xCameraRotate + xDelta > -90 and xCameraRotate + xDelta < 90: 
			camera.rotate_x(deg_to_rad(-xDelta))
			xCameraRotate += xDelta
			
	if event is InputEvent and Input.is_action_just_pressed('escapeKey'):
		get_tree().change_scene_to_file('res://Scenes/MainMenu/main_menu.tscn')


# Character Controller & Physics
func _physics_process(delta):
	
	var headTransform = head.get_global_transform().basis
	var direction = Vector3()

	if Input.is_action_just_pressed('spaceKey') and is_on_floor():
		direction.y = JUMP_POWER

	if not is_on_floor():
		direction.y -= GRAVITY + delta

	if Input.is_action_pressed('wKey'):
		direction -= headTransform.z

	if Input.is_action_pressed('sKey'):
		direction += headTransform.z

	if Input.is_action_pressed('aKey'):
		direction -= headTransform.x

	if Input.is_action_pressed('dKey'):
		direction += headTransform.x


	velocity = velocity.lerp(direction * SPEED, ACCELERATION * delta)
	velocity.y -= GRAVITY
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	velocity = velocity

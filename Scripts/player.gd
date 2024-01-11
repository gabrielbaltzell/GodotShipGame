extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 0.01

var y_axis = Vector3(0, 1, 0)

var boat

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	boat = $Boat
	
	# capture mouse on startup
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("turn_left", "turn_right", "move_forward", "move_backward")
	var direction = (self.transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	if Input.is_action_pressed('turn_left'):
		self.rotate(y_axis, ROTATION_SPEED)
	if Input.is_action_pressed('turn_right'):
		self.rotate(y_axis, -ROTATION_SPEED)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	# release/capture mouse on esc key press
	if Input.is_action_just_pressed("esc"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	self.transform = transform.orthonormalized()
	move_and_slide()

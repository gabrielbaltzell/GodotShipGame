extends Node3D

var boat
var camera

var new_camera_pos := Vector3(0, 0, 0)
var camera_pos_offset := Vector3(0, 1, 2)

var t = 0.0

const CAMERA_PAN_SPEED = 0.001
const CAMERA_ZOOM_SPEED = 4

func _ready():
	boat = get_parent().find_child('Boat')
	camera = $Camera3D
	new_camera_pos = camera.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.look_at(boat.global_position)
	self.global_position = boat.global_position

func _physics_process(delta):
# interpolates between current camera.position and new_camera_pos
	if new_camera_pos != camera.position:
		camera.position = camera.position.lerp(new_camera_pos, delta * CAMERA_ZOOM_SPEED)

func _input(event):
# pan camera around player on horizontal mouse movement
	if event is InputEventMouseMotion:
		global_rotation.y = global_rotation.y + (event.get_relative().x * CAMERA_PAN_SPEED)
# calculates new_camera_pos on mouse scroll
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			new_camera_pos = camera.position + camera_pos_offset
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			new_camera_pos = camera.position - camera_pos_offset
	

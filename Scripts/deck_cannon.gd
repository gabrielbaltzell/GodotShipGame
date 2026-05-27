extends Node3D

var cannonball_scene = preload('res://Scenes/cannonball.tscn')

@onready var player = get_parent()
@onready var muzzle = $Muzzle

func _ready():
	player.fired.connect(fire)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fire():
	var b = cannonball_scene.instantiate()
	add_child(b)
	b.transform = muzzle.transform
	b.velocity = -b.transform.basis.x * b.muzzle_velocity

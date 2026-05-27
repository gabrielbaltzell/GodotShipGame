extends Area3D

@export var muzzle_velocity = 75
@export var g = Vector3.DOWN * 20

var velocity = Vector3.ZERO

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity += g * delta
	transform.origin += velocity * delta


func _on_timer_timeout():
	queue_free()

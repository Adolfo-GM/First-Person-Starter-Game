extends AnimatableBody3D

@export var speed: float = 5.0
@onready var point_a: Node3D = $"../BigCube"
@onready var point_b: Node3D = $"../BigCube2"

var dir: float = 1.0
var t: float = 0.0
var start_y: float

func _ready() -> void:
	start_y = global_transform.origin.y

func _physics_process(delta: float) -> void:
	var a = point_a.global_transform.origin
	var b = point_b.global_transform.origin
	var distance = a.distance_to(b)
	if distance == 0.0:
		return

	var travel = speed * delta / distance
	t += travel * dir

	if t > 1.0:
		t = 1.0
		dir = -1.0
	elif t < 0.0:
		t = 0.0
		dir = 1.0

	var new_pos = a + (b - a) * t
	new_pos.y = start_y
	move_and_collide(new_pos - global_transform.origin)

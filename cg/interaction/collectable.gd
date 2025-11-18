extends Interaction

class_name Collectable

var time : float

var initial_position : Vector3

func _ready() -> void:
	auto_interact = true
	initial_position = global_position

func _physics_process(delta: float) -> void:
	time += delta * 2
	rotate(Vector3(0, 1, 0), delta)
	global_position.y = initial_position.y + (sin(time) / 6)

func _interact() -> void:
	Player.onions += 1
	queue_free()

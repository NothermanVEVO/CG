extends CharacterBody3D

## ANGELINO

const SPEED : float = 500.0
const JUMP_SPEED : float = 300.0
const DECELERATION : float = 0.8

var direction : Vector2

@onready var _corpo : Node3D = $Corpo

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed("Jump"):
		velocity.y = JUMP_SPEED * delta
	
	direction = Input.get_vector("Move Left", "Move Right", "Move Front", "Move Back")
	
	if direction:
		var direction3 := Vector3(direction.x, 0, direction.y).rotated(Vector3(0, 1, 0), $PerspectiveCamera3.rotation.y)
		velocity.x = direction3.x * SPEED * delta ## LEFT OR RIGHT
		velocity.z = direction3.z * SPEED * delta ## BACK OR FRONT
	else:
		velocity.x *= DECELERATION
		velocity.z *= DECELERATION
	
	#velocity = velocity.rotated(Vector3(0, 1, 0), $PerspectiveCamera3.rotation.y)
	
	if direction:
		_corpo.rotation.y = lerp_angle(_corpo.rotation.y, Vector2(velocity.z, velocity.x).angle(), delta * 16)
	
	move_and_slide()

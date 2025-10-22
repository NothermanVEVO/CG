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
		velocity.x = direction.x * SPEED * delta ## LEFT OR RIGHT
		velocity.z = direction.y * SPEED * delta ## BACK OR FRONT
	else:
		velocity.x *= DECELERATION
		velocity.z *= DECELERATION
	
	velocity = velocity.rotated(Vector3(0, 1, 0), $PerspectiveCamera3.rotation.y)
	#print($PerspectiveCamera3.rotation.y)
	
	if direction:
		_corpo.rotation.y = lerp_angle(_corpo.rotation.y, Vector2(velocity.z, velocity.x).angle(), delta * 16)
	
	move_and_slide()

func fuck_u_angle(current_angle : float, new_angle : float) -> void:
	if new_angle < 0:
			new_angle = PI * 2 + new_angle
	
	#current_angle += new_angle
	
	if current_angle >= PI * 2:
		current_angle = fmod(PI * 2, current_angle)
	
	print("Current Angle: " + str(current_angle))

extends Area3D

func _process(delta: float) -> void:
	if not Input.is_action_just_pressed("Interact"):
		return
	
	var bodies := get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			interact()

func interact() -> void:
	print("interact")

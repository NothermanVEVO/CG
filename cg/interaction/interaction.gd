extends Area3D

class_name Interaction

@export var auto_interact : bool = false

func _process(delta: float) -> void:
	if not auto_interact:
		if not Input.is_action_just_pressed("Interact"):
			return
	
	var bodies := get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			_interact()

func _interact() -> void:
	pass

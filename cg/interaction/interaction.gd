extends Area3D

class_name Interaction

@export var auto_interact : bool = false

var player_was_inside_range : bool = false

func _process(_delta: float) -> void:
	var bodies := get_overlapping_bodies()
	
	if not bodies or not is_player_inside_range():
		if player_was_inside_range:
			player_was_inside_range = false
			InteractText.display(false)
		return
	
	if not auto_interact:
		player_was_inside_range = true
		InteractText.display(true)
	
	if not auto_interact:
		if not Input.is_action_just_pressed("Interact"):
			return
	
	for body in bodies:
		if body is Player:
			_interact()

func is_player_inside_range() -> bool:
	var bodies := get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			return true
	return false

func _interact() -> void:
	pass

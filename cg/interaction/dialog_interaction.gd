extends Interaction

class_name DialogInteraction

@export var dialogs : Array[Dialogs]

var current_dialog := 0

func _interact() -> void:
	if current_dialog < dialogs.size():
		DialogHandler.start_dialog(dialogs[current_dialog])
		current_dialog += 1

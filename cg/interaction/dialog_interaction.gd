extends Interaction

class_name DialogInteraction

@export var dialogs : Array[Dialogs]

var current_dialog := 0

var wait_for_condition : bool = false

func _interact() -> void:
	if current_dialog < dialogs.size() and DialogHandler.can_start_dialog():
		DialogHandler.start_dialog(dialogs[current_dialog])
		if dialogs[current_dialog].wait_for_condition:
			wait_for_condition = true
			if not DialogHandler.condition_checked.is_connected(_condition_checked):
				DialogHandler.condition_checked.connect(_condition_checked)
			return
		current_dialog += 1

func _condition_checked(happened : bool) -> void:
	if wait_for_condition and happened:
		current_dialog += 1
		wait_for_condition = false

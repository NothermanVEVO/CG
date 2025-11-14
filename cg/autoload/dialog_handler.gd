extends Node

signal choice_selected

enum Choices{MISSION_1_IM_GOOD, MISSION_1_IM_NOT_GOOD}

var dialog_box : DialogBox

func start_dialog(dialogs : Dialogs) -> void:
	dialog_box.start(dialogs)
	dialog_box.visible = true
	await dialog_box.dialog_ended
	dialog_box.visible = false

func handle_dialog_id(ID : int) -> void:
	match ID:
		_:
			print("epa")
			pass

func handle_option_id(ID : int) -> void:
	match ID:
		Choices.MISSION_1_IM_GOOD:
			print("ok")
		Choices.MISSION_1_IM_NOT_GOOD:
			print("not ok")
	choice_selected.emit()

extends Node

signal choice_selected

enum DialogID{NOTHING, CLOSE_GAME, CHECK_FOR_5_ONIONS, DISPLAY_UI}
enum Choices{MISSION_1_IM_GOOD, MISSION_1_IM_NOT_GOOD, MISSION_2_ACCEPT, MISSION_2_REFUSE}

var dialog_box : DialogBox

signal condition_checked(happened : bool)

func can_start_dialog() -> bool:
	return not dialog_box.has_started()

func start_dialog(dialogs : Dialogs) -> void:
	dialog_box.start(dialogs)
	dialog_box.visible = true
	await dialog_box.dialog_ended
	dialog_box.visible = false

func handle_dialog_id(ID : int) -> void:
	match ID:
		DialogID.CLOSE_GAME:
			get_tree().quit()
		DialogID.CHECK_FOR_5_ONIONS:
			condition_checked.emit(Player.onions == 5)
			if Player.onions == 5:
				start_dialog.call_deferred(load("res://dialog/resources/collect onion mission 1/4_mission.tres"))
		DialogID.DISPLAY_UI:
			UI.make_visible()
		_:
			pass

func handle_option_id(ID : int) -> void:
	match ID:
		Choices.MISSION_1_IM_GOOD:
			start_dialog.call_deferred(load("res://dialog/resources/collect onion mission 1/1_mission_option_tudo sim.tres"))
		Choices.MISSION_1_IM_NOT_GOOD:
			start_dialog.call_deferred(load("res://dialog/resources/collect onion mission 1/1_mission_option_na verdade nao.tres"))
		Choices.MISSION_2_ACCEPT:
			start_dialog.call_deferred(load("res://dialog/resources/collect onion mission 1/2_mission_aceitou.tres"))
		Choices.MISSION_2_REFUSE:
			start_dialog.call_deferred(load("res://dialog/resources/collect onion mission 1/2_mission_nao_aceitou.tres"))
	choice_selected.emit()

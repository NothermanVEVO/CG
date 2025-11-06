extends Node

signal choice_selected

const ACCEPT_ONIONS_MISSION : int = 0
const DENY_ONIONS_MISSION : int = 1
const SHIT_IN_THE_MISSION : int = 2

func handle_id(ID : int) -> void:
	match ID:
		ACCEPT_ONIONS_MISSION:
			print("Aceitou")
		DENY_ONIONS_MISSION:
			print("Recusou")
		SHIT_IN_THE_MISSION:
			print("Já te falaram que você é estranho?")
	choice_selected.emit()

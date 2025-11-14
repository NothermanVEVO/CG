extends Resource

class_name Choice

const _CHOICE_BUTTON_SCENE : PackedScene = preload("res://dialog/choice/choice_button.tscn")

@export var text : String
@export var oi : int
@export var ID : DialogHandler.Choices

func create_choice_button() -> ChoiceButton:
	var choice_button : ChoiceButton = _CHOICE_BUTTON_SCENE.instantiate()
	choice_button.setup(self)
	return choice_button

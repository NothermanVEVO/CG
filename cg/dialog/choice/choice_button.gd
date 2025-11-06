extends MarginContainer

class_name ChoiceButton

var choice : Choice

signal choice_selected(ID : int)

@warning_ignore("shadowed_variable")
func setup(choice : Choice) -> void:
	self.choice = choice
	if is_inside_tree():
		$MarginContainer/RichTextLabel.text = choice.text

func _ready() -> void:
	if choice:
		$MarginContainer/RichTextLabel.text = choice.text

func _on_button_pressed() -> void:
	if choice:
		choice_selected.emit(choice.ID)

extends MarginContainer

class_name InteractText

static var displayer : InteractText

func _ready() -> void:
	displayer = self

static func display(can_display : bool) -> void:
	displayer.visible = can_display

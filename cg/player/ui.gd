extends MarginContainer

class_name UI

static var ui : UI
static var rich_text : RichTextLabel

func _ready() -> void:
	ui = self
	rich_text = $RichTextLabel
	visible = false

func _process(_delta: float) -> void:
	set_onions(Player.onions)

static func set_onions(onions : int) -> void:
	rich_text.text = "Cebolas: " + str(onions) + "/5"

static func make_visible() -> void:
	ui.visible = true

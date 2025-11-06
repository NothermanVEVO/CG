extends Control

class_name DialogBox

@onready var _name_text : RichTextLabel = $MarginContainer/Nome/RichTextLabel
@onready var _dialog_text : RichTextLabel = $MarginContainer/Texto/RichTextLabel

const _NORMAL_CHARACTERS : float = 0.05
const _SPECIAL_CHARACTERS : float = 0.1
const _PONTUATION_CHARACTERS : float = 0.5

var speed : float = 1.5

var _timer := Timer.new()

var _started : bool = false
var _can_change_dialog : bool = false
var _can_end_dialog : bool = false

signal change_dialog
signal dialog_ended

func _ready() -> void:
	add_child(_timer)
	start(load("res://dialog/resources/test/padrao1.tres"))

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Finish Dialog"):
		_finish_dialog()

func start(dialogs : Dialogs) -> void:
	if _started:
		return
	
	_started = true
	
	for dialog in dialogs.dialogs:
		_name_text.text = dialog.character_name
		_dialog_text.text = dialog.text
		
		_dialog_text.visible_characters = 0
		_run_dialog(_compile_text(dialog.text))
		await change_dialog
	_started = false
	dialog_ended.emit()

func _run_dialog(text : String) -> void:
	_can_change_dialog = false
	var _maximum_visible_characters : int = text.length()
	for i in _maximum_visible_characters:
		_dialog_text.visible_characters = i + 1
		match text[i]:
			'.', '!', '?':
				_timer.start(_PONTUATION_CHARACTERS / speed)
				await _timer.timeout
			'\'', '\"', ',', ';', ':', '(', ')', '-', '+', "=":
				_timer.start(_SPECIAL_CHARACTERS / speed)
				await _timer.timeout
			_:
				_timer.start(_NORMAL_CHARACTERS / speed)
				await _timer.timeout
		if _can_end_dialog:
			_dialog_text.visible_characters = -1
			_can_end_dialog = false
			break
	_can_change_dialog = true

func _finish_dialog() -> void:
	if _can_change_dialog:
		change_dialog.emit()
	else:
		_can_end_dialog = true
		_timer.timeout.emit()

## REMOVE THE BBCODE TAGS
func _compile_text(text : String) -> String:
	var regex := RegEx.new()
	regex.compile("\\[([^]])+\\]")
	var new_text = text
	while regex.search(new_text):
		var matches := regex.search(new_text)
		new_text = new_text.replace(matches.strings[0], "")
	return new_text

func has_started() -> bool:
	return _started

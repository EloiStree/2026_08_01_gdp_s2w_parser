class_name S2W2DInputLineToInteger
extends Node


signal on_integer_found(integer:int)
signal on_last_text_not_valid(text:String)

@export var _line_editor:LineEdit
@export var _listen_to_changed:bool = true
@export var _listen_to_submit:bool = true

func _ready() -> void:
	if _listen_to_changed:
		_line_editor.text_changed.connect(_parse_text_to_integer)
	if _listen_to_submit:
		_line_editor.text_submitted.connect(_parse_text_to_integer)

func _parse_text_to_integer(text:String) -> void:
	if is_text_integer(text):
		var integer:int = parse_text_to_integer(text)
		on_integer_found.emit(integer)
	else:
		on_last_text_not_valid.emit(text)


func is_text_integer(text:String) -> bool:
	return text.is_valid_int()

func parse_text_to_integer(text:String) -> int:
	return int(text)

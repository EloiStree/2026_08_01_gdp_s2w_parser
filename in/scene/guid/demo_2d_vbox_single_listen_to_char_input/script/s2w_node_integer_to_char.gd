class_name S2WListenToCharAsInteger
extends Node

signal on_char_found(char:String)
signal on_char_as_formated_string(format_string:String)
signal on_last_integer_not_valide()

@export var _last_received_integer:int
@export var _last_received_char:String
@export var _debug_label:Array[Label] = []
@export var _format_string:String = "Integer: %d, Char: %s"

func emit_char_if_found_from_integer(integer:int)->void:
	_last_received_integer = integer	
	_last_received_char = S2WStaticIntegerToChar.get_char_from_integer(integer)
	if _last_received_char != "":
		on_char_found.emit(_last_received_char)
	else:
		on_last_integer_not_valide.emit()

	for label in _debug_label:
		if label != null:
			label.text = _format_string % [integer, _last_received_char]
			on_char_as_formated_string.emit(label.text)
	var t:String= _format_string % [integer, _last_received_char]
	on_char_as_formated_string.emit(t)

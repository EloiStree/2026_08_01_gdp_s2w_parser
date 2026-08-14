class_name S2WUIKeyValueAsText
extends Node

signal on_key_value_as_string(formated_text:String)
@export var _format_string:String = "%s:%s"
@export var _labels:Array[Label] = []

func push_as_key_variante(key:String, value:Variant) -> void:
	var formated_text = _format_string % [key, str(value)]
	on_key_value_as_string.emit(formated_text)
	for label in _labels:
		label.text = formated_text

func push_as_Key_boolean(key:String, value:bool) -> void:
	var formated_text = _format_string % [key, str(value)]
	on_key_value_as_string.emit(formated_text)
	for label in _labels:
		if label != null:
			label.text = formated_text
			if value:
				label.add_theme_color_override("font_color", Color(0, 1, 0))
			else:
				label.add_theme_color_override("font_color", Color(1, 0, 0))

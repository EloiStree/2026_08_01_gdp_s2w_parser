class_name S2WParsePackOfBytesToII
extends Node


signal on_integer_value_received(value: int)
signal on_integer_index_value_received(index: int,value: int)
signal on_any_integer_value_received(value: int)
signal on_any_integer_value_received_as_string(value: String)

func push_in_to_parse(data: PackedByteArray) -> void:
	if data.size() == 4:
		var int_value: int = data.decode_s32(0)
		on_integer_value_received.emit(int_value)
		on_any_integer_value_received.emit(int_value)
		on_any_integer_value_received_as_string.emit(str(int_value))
	elif data.size() == 8:
		var index: int = data.decode_s32(0)
		var value: int = data.decode_s32(4)
		on_integer_index_value_received.emit(index, value)
		on_any_integer_value_received.emit(value)
		on_any_integer_value_received_as_string.emit(str(value))
	elif  data.size() == 12:
		var value: int = data.decode_s32(0)
		on_integer_value_received.emit(value)
		on_any_integer_value_received.emit(value)
		on_any_integer_value_received_as_string.emit(str(value))
	elif  data.size() == 16:
		var index: int = data.decode_s32(0)
		var value: int = data.decode_s32(4)
		on_integer_index_value_received.emit(index, value)
		on_any_integer_value_received.emit(value)
		on_any_integer_value_received_as_string.emit(str(value))

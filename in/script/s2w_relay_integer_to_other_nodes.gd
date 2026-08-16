class_name S2WRelayIntegerToOtherNodes
extends Node

signal on_relayed_integer(value:int)
@export var _nodes_to_broadcast_to: Array[Node] = []
@export var _method_to_broadcast_to: Array[String] = ["push_in_integer"]


const digit:Array[String] = ["0","1","2","3","4","5","6","7","8","9","-"]

func is_integer_string(value:String) -> bool:
	for i in value:
		if not digit.has(i):
			return false
	return true

func push_in_integer_as_string(value:String):
	if is_integer_string(value):
		push_in_integer(value.to_int())
	
func push_in_integer(value:int):
	on_relayed_integer.emit(value)
	for node in _nodes_to_broadcast_to:
		for method in _method_to_broadcast_to:
			if node.has_method(method):
				node.call(method, value)

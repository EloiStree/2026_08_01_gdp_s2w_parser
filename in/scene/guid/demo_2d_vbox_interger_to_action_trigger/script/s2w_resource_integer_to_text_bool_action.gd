class_name S2WResourceIntegerToTextBoolAction
extends Resource


@export var dictionary_integer_to_boolean_actions:Dictionary[int, Array] = {
	1032: ["SPACE"],
	1037: ["LEFT_ARROW"],
	1039: ["RIGHT_ARROW"],
	1040: ["DOWN_ARROW"],
	1038: ["UP_ARROW"],
	1009: ["TAB"],
}
@export var dictionary_integer_to_actions_enter:Dictionary[int, Array] = {
	1009: ["TAB_DOWN"],
}
@export var dictionary_integer_to_actions_exit:Dictionary[int, Array] = {
	1009: ["TAB_UP"],
}


func get_action_to_trigger_from_integer_enter(integer:int) -> Array:
	if dictionary_integer_to_actions_enter.has(integer):
		return dictionary_integer_to_actions_enter[integer]
	else:
		return []

func get_action_to_trigger_from_integer_exit(integer:int) -> Array:
	if dictionary_integer_to_actions_exit.has(integer):
		return dictionary_integer_to_actions_exit[integer]
	else:
		return []


func get_boolean_action_to_trigger_from_integer(integer:int) -> Array:
	if dictionary_integer_to_boolean_actions.has(integer):
		return dictionary_integer_to_boolean_actions[integer]
	else:
		return []

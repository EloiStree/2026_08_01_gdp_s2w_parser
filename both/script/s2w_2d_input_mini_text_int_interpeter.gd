## For testing, this is a mini interpreter that turn integer and delay actions.
class_name S2W2DInputMiniTextIntInterpreter
extends Node

signal on_integer_submitted(integer:int)
signal on_integer_submitted_as_string(integer:String)

@export var _text_editor:TextEdit
@export var _submit_button:Button
@export var _listen_to_change:bool = true
@export var _listen_to_submit:bool = true

@export_group("Debug")
@export var _last_pushed_integer:int = 0
@export var _use_debug_print:bool = false

func _ready() -> void:
	if _listen_to_change:
		_text_editor.text_changed.connect(_push_text_editor_text_from_text)
	if _listen_to_submit:
		_submit_button.pressed.connect(_push_text_editor_text_to_integer)


func _push_text_editor_text_from_text(text:String) -> void:
	parse_text_to_integer(text)

func _push_text_editor_text_to_integer() -> void:
	var text:String = _text_editor.text
	if _use_debug_print:
		print("submit text: ", text)
	parse_text_to_integer(text)


func is_text_time_delay_symbole(text:String) -> bool:
	return text.ends_with(">")

func get_delay_time_from_text(text:String) -> int:
	var delay_time_str:String = text.strip_edges().trim_suffix(">")
	if not is_text_integer(delay_time_str):
		return 0
	return int(delay_time_str)


var digit_array:Array = ["-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
func is_text_integer(text:String) -> bool:
	text = text.strip_edges()
	if text == "":
		return false
	## return false if one is not digit
	for char in text:
		if not digit_array.has(char):
			return false
	return true

var delayer:Delayer = Delayer.new()

func parse_text_to_integer(text:String) -> void:
	var words:Array = text.split(" ")
	var milliseconds_delay:int = 0
	for word in words:
		if is_text_integer(word):
			var integer:int = int(word)
			delayer.add_delayed_integer(integer, milliseconds_delay)		
			if _use_debug_print:
				print("Delayed integer: ", integer, " with delay: ", milliseconds_delay, " milliseconds	")
		elif is_text_time_delay_symbole(word):
			milliseconds_delay += get_delay_time_from_text(word)
			if _use_debug_print:
				print("Delay time updated to: ", milliseconds_delay, " milliseconds	")

func _process(delta:float) -> void:
	var expired_integers:Array[DelayedInteger] = delayer.remove_expired_delayed_integers()
	for expired_integer in expired_integers:
		if _use_debug_print:
			print("Expired integer: ", expired_integer.integer, " at time: ", delayer.get_current_time_in_milliseconds(), " milliseconds	")
		_last_pushed_integer = expired_integer.integer
		on_integer_submitted.emit(expired_integer.integer)	
		on_integer_submitted_as_string.emit( str(expired_integer.integer) )

class DelayedInteger:
	var integer:int
	var game_time_milliseconds:int

	func _init(integer:int, game_time_milliseconds:int) -> void:
		self.integer = integer
		self.game_time_milliseconds = game_time_milliseconds

class Delayer:

	var delayed_integers:Array = []

	func get_current_time_in_milliseconds() -> int:
		return Time.get_ticks_msec()

	func add_delayed_integer(integer:int, delay_milliseconds:int) -> void:
		var current_time:int = get_current_time_in_milliseconds()
		var delayed_integer:DelayedInteger = DelayedInteger.new(integer, current_time + delay_milliseconds)
		delayed_integers.append(delayed_integer)


	func remove_expired_delayed_integers() -> Array[DelayedInteger]:
		var current_time:int = get_current_time_in_milliseconds()
		var expired_integers:Array[DelayedInteger] = []
		for delayed_integer in delayed_integers:
			if current_time >= delayed_integer.game_time_milliseconds:
				expired_integers.append(delayed_integer)
		for expired_integer in expired_integers:
			delayed_integers.erase(expired_integer)
		return expired_integers

class_name S2WListenToSingleMotors
extends Node


signal on_motor_1_value(value_percent_0_1: float)
signal on_motor_2_value(value_percent_0_1: float)
signal on_motor_3_value(value_percent_0_1: float)
signal on_motor_4_value(value_percent_0_1: float)
signal on_motor_5_value(value_percent_0_1: float)
signal on_motor_6_value(value_percent_0_1: float)
signal on_motor_7_value(value_percent_0_1: float)
signal on_motor_8_value(value_percent_0_1: float)
signal on_motors_value_as_array(value_in_percent_0_1: Array[float])

signal on_motor_value_updated_specificaly(motor_index:int, value_percent_0_1: float)
signal on_motor_1699988888_value_received(motor_index_999:int, motor_value_99999: int)
signal on_motor_1699988888_value_received_as_string(debug_formated_text: String)




@export var _9998888_format_string:String = "Motor ID: %d, Percent: %.5f"

@export_group("Debug of motors 1-8")
@export var _motor_1_8_int: Array[int]= [0, 0, 0, 0, 0, 0, 0, 0]
@export var _motor_1_8_float: Array[float]= [0, 0, 0, 0, 0, 0, 0, 0]

@export_group("Slider UI Debug")
@export var _motors_as_slider:Array[Slider] = []


func push_in_integer(value: int) -> void:
	##16987654321 where 16 is an entry tag
	if  value >=1600000000 and value < 1700000000:
		if _motor_1_8_int.size() != 8:
			_motor_1_8_int.resize(8)
		if _motor_1_8_float.size() != 8:
			_motor_1_8_float.resize(8)
		_motor_1_8_int[0] = int((value / 10000000) % 10)
		_motor_1_8_int[1] = int((value / 1000000) % 10)
		_motor_1_8_int[2] = int((value / 100000) % 10)
		_motor_1_8_int[3] = int((value / 10000) % 10)
		_motor_1_8_int[4] = int((value / 1000) % 10)
		_motor_1_8_int[5] = int((value / 100) % 10)
		_motor_1_8_int[6] = int((value / 10) % 10)
		_motor_1_8_int[7] = int(value % 10)
		for i in range(8):
			_motor_1_8_float[i] = parse_digit_to_percent_0_9(_motor_1_8_int[i])
		on_motor_1_value.emit(_motor_1_8_float[0])
		on_motor_2_value.emit(_motor_1_8_float[1])
		on_motor_3_value.emit(_motor_1_8_float[2])
		on_motor_4_value.emit(_motor_1_8_float[3])
		on_motor_5_value.emit(_motor_1_8_float[4])
		on_motor_6_value.emit(_motor_1_8_float[5])
		on_motor_7_value.emit(_motor_1_8_float[6])
		on_motor_8_value.emit(_motor_1_8_float[7])
		on_motors_value_as_array.emit(_motor_1_8_float)

	## if between   -1600000000 and -1700000000 then it is a negative value for motors 1-8
	elif  value <= -1600000000 and value > -1700000000:
		## -16 one motor at a time
		## -1699988888
		## 999 id  of the motor 0 to 999
		## 88888 percent 0 to 99999

		var value_int :int = abs(value)
		var motor_999_id:int = int((value_int / 100000) % 1000)
		var motor_99999_percent_as_int:int = int(value_int % 100000)
		var motor_percent:float = float(motor_99999_percent_as_int)/ 100000.0

		if motor_999_id >= 0 and motor_999_id < 8:
			_motor_1_8_int[motor_999_id] = int(motor_percent*9.0)
			_motor_1_8_float[motor_999_id] = motor_percent
			if _motors_as_slider.size() != 8:
				_motors_as_slider.resize(8)
			if _motors_as_slider[motor_999_id] != null:
				_motors_as_slider[motor_999_id].value = motor_percent	
			if motor_999_id == 0:
				on_motor_1_value.emit(motor_percent)
			elif motor_999_id == 1:
				on_motor_2_value.emit(motor_percent)
			elif motor_999_id == 2:
				on_motor_3_value.emit(motor_percent)
			elif motor_999_id == 3:
				on_motor_4_value.emit(motor_percent)
			elif motor_999_id == 4:
				on_motor_5_value.emit(motor_percent)
			elif motor_999_id == 5:
				on_motor_6_value.emit(motor_percent)
			elif motor_999_id == 6:
				on_motor_7_value.emit(motor_percent)
			elif motor_999_id == 7:
				on_motor_8_value.emit(motor_percent)
			on_motors_value_as_array.emit(_motor_1_8_float)	
		
		if motor_999_id >= 0 and motor_999_id <= 999:
			on_motor_value_updated_specificaly.emit(motor_999_id, motor_percent) 
		
		on_motor_1699988888_value_received.emit(motor_999_id, motor_percent)
		var text = _9998888_format_string % [motor_999_id, motor_percent]
		on_motor_1699988888_value_received_as_string.emit(text)

	for i in range(_motors_as_slider.size()):
		if _motors_as_slider[i] != null :
			_motors_as_slider[i].value = _motor_1_8_float[i]
		
func parse_digit_to_percent_0_9(value: int) -> float:
	if value < 0:
		return 0.0
	elif value > 9:
		return 1.0
	else:
		return float(value) / 9.0

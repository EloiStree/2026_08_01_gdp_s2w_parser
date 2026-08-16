class_name S2WListenToKeyboardInt
extends Node


signal on_any_integer_received(integer:int)
signal on_any_integer_received_as_string(integer:String)
signal on_keyboard_integer_received(integer_key_type:int, is_pressing:bool)
signal on_triggered_value_action_found(action:String, is_pressing:bool)
signal on_triggered_action_found(action:String)

signal on_key_numpad_digit_event(digit_0_10:int, is_pressing:bool)
signal on_key_alpha_digit_event(digit_0_10:int, is_pressing:bool)
signal on_key_function_key_event(digit_1_12:int, is_pressing:bool)
signal on_key_alpha_character_upper_event(character:String, is_pressing:bool)
signal on_main_escape_key_event(is_pressing:bool)
signal on_main_tab_key_event(is_pressing:bool)
signal on_main_shift_key_event(is_pressing:bool)
signal on_main_ctrl_key_event(is_pressing:bool)
signal on_main_alt_key_event(is_pressing:bool)
signal on_main_space_key_event(is_pressing:bool)
signal on_main_enter_key_event(is_pressing:bool)
signal on_main_backspace_key_event(is_pressing:bool)
signal on_side_insert_key_event(is_pressing:bool)
signal on_side_delete_key_event(is_pressing:bool)
signal on_side_home_key_event(is_pressing:bool)
signal on_side_end_key_event(is_pressing:bool)
signal on_side_page_up_key_event(is_pressing:bool)
signal on_side_page_down_key_event(is_pressing:bool)
signal on_arrow_up_key_event(is_pressing:bool)
signal on_arrow_down_key_event(is_pressing:bool)
signal on_arrow_left_key_event(is_pressing:bool)
signal on_arrow_right_key_event(is_pressing:bool)

signal on_numpad_add(is_pressing:bool)
signal on_numpad_subtract(is_pressing:bool)
signal on_numpad_multiply(is_pressing:bool)
signal on_numpad_divide(is_pressing:bool)
signal on_numpad_decimal(is_pressing:bool)


@export var _link_integer_to_text_action:S2WResourceIntegerToTextBoolAction

@export var _last_received_integer:int = -1
@export var _last_received_integer_key_type:int = -1
@export var _last_received_integer_is_pressing:bool = false


func push_in_integer(integer_value:int):
	on_any_integer_received.emit(integer_value)
	on_any_integer_received_as_string.emit(str(integer_value))
	if  integer_value < 1000 or integer_value >= 3000:
		return
	var is_pressing:bool = integer_value >= 1000 and integer_value < 2000
	var key_type:int = (integer_value % 1000) + 1000
	_last_received_integer = integer_value
	_last_received_integer_key_type = key_type
	_last_received_integer_is_pressing = is_pressing
	on_keyboard_integer_received.emit(key_type, is_pressing)
	_check_for_integer_to_event(key_type, is_pressing)
	if _link_integer_to_text_action != null:
		if is_pressing:
			var actions_to_trigger_enter:Array = _link_integer_to_text_action.get_action_to_trigger_from_integer_enter(key_type)
			for action in actions_to_trigger_enter:
				on_triggered_action_found.emit(action)

		var boolean_actions_to_trigger:Array = _link_integer_to_text_action.get_boolean_action_to_trigger_from_integer(key_type)
		for action in boolean_actions_to_trigger:
			on_triggered_value_action_found.emit(action, is_pressing)

		if not is_pressing:
			var actions_to_trigger_exit:Array = _link_integer_to_text_action.get_action_to_trigger_from_integer_exit(key_type)
			for action in actions_to_trigger_exit:
				on_triggered_action_found.emit(action)

func _check_for_integer_to_event(key_type:int, is_pressing:bool):
	match key_type:
		INT_TAB:
			on_main_tab_key_event.emit(is_pressing)
			return
		INT_SPACE:
			on_main_space_key_event.emit(is_pressing)
			return
		INT_ENTER:
			on_main_enter_key_event.emit(is_pressing)
			return
		INT_BACKSPACE:
			on_main_backspace_key_event.emit(is_pressing)
			return
		INT_ESCAPE:
			on_main_escape_key_event.emit(is_pressing)
			return

		INT_ARROW_LEFT:
			on_arrow_left_key_event.emit(is_pressing)
			return
		INT_ARROW_RIGHT:
			on_arrow_right_key_event.emit(is_pressing)
			return
		INT_ARROW_DOWN:
			on_arrow_down_key_event.emit(is_pressing)
			return
		INT_ARROW_UP:
			on_arrow_up_key_event.emit(is_pressing)
			return

		INT_INSERT:
			on_side_insert_key_event.emit(is_pressing)
			return
		INT_DELETE:
			on_side_delete_key_event.emit(is_pressing)
			return
		INT_HOME:
			on_side_home_key_event.emit(is_pressing)
			return
		INT_END:
			on_side_end_key_event.emit(is_pressing)
			return
		INT_PAGE_UP:
			on_side_page_up_key_event.emit(is_pressing)
			return
		INT_PAGE_DOWN:
			on_side_page_down_key_event.emit(is_pressing)
			return
			
		INT_SHIFT or INT_LEFT_SHIFT or INT_RIGHT_SHIFT:
			on_main_shift_key_event.emit(is_pressing)
			return
		INT_CTRL or INT_LEFT_CTRL or INT_RIGHT_CTRL:
			on_main_ctrl_key_event.emit(is_pressing)
			return
		INT_ALT or INT_LEFT_ALT or INT_RIGHT_ALT:
			on_main_alt_key_event.emit(is_pressing)
			return


	match key_type:
		
		INT_NUMPAD_0:
			on_key_numpad_digit_event.emit(0,is_pressing)
			return
		INT_NUMPAD_1:
			on_key_numpad_digit_event.emit(1,is_pressing)
			return
		INT_NUMPAD_2:
			on_key_numpad_digit_event.emit(2,is_pressing)
			return
		INT_NUMPAD_3:
			on_key_numpad_digit_event.emit(3,is_pressing)
			return
		INT_NUMPAD_4:
			on_key_numpad_digit_event.emit(4,is_pressing)
			return
		INT_NUMPAD_5:
			on_key_numpad_digit_event.emit(5,is_pressing)
			return
		INT_NUMPAD_6:
			on_key_numpad_digit_event.emit(6,is_pressing)
			return
		INT_NUMPAD_7:
			on_key_numpad_digit_event.emit(7,is_pressing)
			return
		INT_NUMPAD_8:
			on_key_numpad_digit_event.emit(8,is_pressing)
			return
		INT_NUMPAD_9:
			on_key_numpad_digit_event.emit(9,is_pressing)
			return
		INT_ALPHA_0:
			on_key_alpha_digit_event.emit(0,is_pressing)
			return
		INT_ALPHA_1:
			on_key_alpha_digit_event.emit(1,is_pressing)
			return
		INT_ALPHA_2:
			on_key_alpha_digit_event.emit(2,is_pressing)
			return
		INT_ALPHA_3:
			on_key_alpha_digit_event.emit(3,is_pressing)
			return
		INT_ALPHA_4:
			on_key_alpha_digit_event.emit(4,is_pressing)
			return
		INT_ALPHA_5:
			on_key_alpha_digit_event.emit(5,is_pressing)
			return
		INT_ALPHA_6:
			on_key_alpha_digit_event.emit(6,is_pressing)
			return
		INT_ALPHA_7:
			on_key_alpha_digit_event.emit(7,is_pressing)
			return
		INT_ALPHA_8:
			on_key_alpha_digit_event.emit(8,is_pressing)
			return
		INT_ALPHA_9:
			on_key_alpha_digit_event.emit(9,is_pressing)
			return

		INT_F1:
			on_key_function_key_event.emit(1,is_pressing)
			return
		INT_F2:
			on_key_function_key_event.emit(2,is_pressing)
			return
		INT_F3:
			on_key_function_key_event.emit(3,is_pressing)
			return
		INT_F4:
			on_key_function_key_event.emit(4,is_pressing)
			return
		INT_F5:
			on_key_function_key_event.emit(5,is_pressing)
			return
		INT_F6:
			on_key_function_key_event.emit(6,is_pressing)
			return
		INT_F7:
			on_key_function_key_event.emit(7,is_pressing)
			return
		INT_F8:
			on_key_function_key_event.emit(8,is_pressing)
			return
		INT_F9:
			on_key_function_key_event.emit(9,is_pressing)
			return
		INT_F10:
			on_key_function_key_event.emit(10,is_pressing)
			return
		INT_F11:
			on_key_function_key_event.emit(11,is_pressing)
			return
		INT_F12:
			on_key_function_key_event.emit(12,is_pressing)
			return
		INT_NUMPAD_MULTIPLY:
			on_numpad_multiply.emit(is_pressing)
			return
		INT_NUMPAD_ADD:
			on_numpad_add.emit(is_pressing)
			return
		INT_NUMPAD_SUBTRACT:
			on_numpad_subtract.emit(is_pressing)
			return
		INT_NUMPAD_DIVIDE:
			on_numpad_divide.emit(is_pressing)
			return
		INT_NUMPAD_DECIMAL:
			on_numpad_decimal.emit(is_pressing)
			return
		INT_KEY_A:
			on_key_alpha_character_upper_event.emit(INT_KEY_A_CHAR, is_pressing)
			return
		INT_KEY_B:
			on_key_alpha_character_upper_event.emit(INT_KEY_B_CHAR, is_pressing)
			return
		INT_KEY_C:
			on_key_alpha_character_upper_event.emit(INT_KEY_C_CHAR, is_pressing)
			return
		INT_KEY_D:
			on_key_alpha_character_upper_event.emit(INT_KEY_D_CHAR, is_pressing)
			return
		INT_KEY_E:
			on_key_alpha_character_upper_event.emit(INT_KEY_E_CHAR, is_pressing)
			return
		INT_KEY_F:
			on_key_alpha_character_upper_event.emit(INT_KEY_F_CHAR, is_pressing)
			return
		INT_KEY_G:
			on_key_alpha_character_upper_event.emit(INT_KEY_G_CHAR, is_pressing)
			return
		INT_KEY_H:
			on_key_alpha_character_upper_event.emit(INT_KEY_H_CHAR, is_pressing)
			return
		INT_KEY_I:
			on_key_alpha_character_upper_event.emit(INT_KEY_I_CHAR, is_pressing)
			return
		INT_KEY_J:
			on_key_alpha_character_upper_event.emit(INT_KEY_J_CHAR, is_pressing)
			return
		INT_KEY_K:
			on_key_alpha_character_upper_event.emit(INT_KEY_K_CHAR, is_pressing)
			return
		INT_KEY_L:
			on_key_alpha_character_upper_event.emit(INT_KEY_L_CHAR, is_pressing)
			return
		INT_KEY_M:
			on_key_alpha_character_upper_event.emit(INT_KEY_M_CHAR, is_pressing)
			return
		INT_KEY_N:
			on_key_alpha_character_upper_event.emit(INT_KEY_N_CHAR, is_pressing)
			return
		INT_KEY_O:
			on_key_alpha_character_upper_event.emit(INT_KEY_O_CHAR, is_pressing)
			return
		INT_KEY_P:
			on_key_alpha_character_upper_event.emit(INT_KEY_P_CHAR, is_pressing)
			return
		INT_KEY_Q:
			on_key_alpha_character_upper_event.emit(INT_KEY_Q_CHAR, is_pressing)
			return
		INT_KEY_R:
			on_key_alpha_character_upper_event.emit(INT_KEY_R_CHAR, is_pressing)
			return
		INT_KEY_S:
			on_key_alpha_character_upper_event.emit(INT_KEY_S_CHAR, is_pressing)
			return
		INT_KEY_T:
			on_key_alpha_character_upper_event.emit(INT_KEY_T_CHAR, is_pressing)
			return
		INT_KEY_U:
			on_key_alpha_character_upper_event.emit(INT_KEY_U_CHAR, is_pressing)
			return
		INT_KEY_V:
			on_key_alpha_character_upper_event.emit(INT_KEY_V_CHAR, is_pressing)
			return
		INT_KEY_W:
			on_key_alpha_character_upper_event.emit(INT_KEY_W_CHAR, is_pressing)
			return
		INT_KEY_X:
			on_key_alpha_character_upper_event.emit(INT_KEY_X_CHAR, is_pressing)
			return
		INT_KEY_Y:
			on_key_alpha_character_upper_event.emit(INT_KEY_Y_CHAR, is_pressing)
			return
		INT_KEY_Z:
			on_key_alpha_character_upper_event.emit(INT_KEY_Z_CHAR, is_pressing)
			return
		

# Backspace 	8 	0x08 	1008 	2008
# Tab 	9 	0x09 	1009 	2009
# Enter 	13 	0x0D 	1013 	2013
const INT_BACKSPACE:int = 1008
const INT_TAB:int = 1009
const INT_ENTER:int = 1013

# Escape 	27 	0x1B 	1027 	2027
# Space 	32 	0x20 	1032 	2032
const INT_ESCAPE:int = 1027
const INT_SPACE:int = 1032

# Shift 	16 	0x10 	1016 	2016
# Ctrl 	17 	0x11 	1017 	2017
# Alt 	18 	0x12 	1018 	2018
const INT_SHIFT:int = 1016
const INT_LEFT_SHIFT:int = 1160
const INT_RIGHT_SHIFT:int = 1161
const INT_CTRL:int = 1017
const INT_LEFT_CTRL:int = 1162
const INT_RIGHT_CTRL:int = 1163
const INT_ALT:int = 1018
const INT_LEFT_ALT:int = 1164
const INT_RIGHT_ALT:int = 1165


# LeftArrow 	37 	0x25 	1037 	2037
# UpArrow 	38 	0x26 	1038 	2038
# RightArrow 	39 	0x27 	1039 	2039
# DownArrow 	40 	0x28 	1040 	2040
const INT_ARROW_LEFT:int = 1037
const INT_ARROW_RIGHT:int = 1039
const INT_ARROW_DOWN:int = 1040
const INT_ARROW_UP:int = 1038

# Insert 	45 	0x2D 	1045 	2045
# Delete 	46 	0x2E 	1046 	2046
# PageUp 	33 	0x21 	1033 	2033
# PageDown 	34 	0x22 	1034 	2034
# End 	35 	0x23 	1035 	2035
# Home 	36 	0x24 	1036 	2036

const INT_INSERT:int = 1045
const INT_DELETE:int = 1046
const INT_HOME:int = 1036
const INT_END:int = 1035
const INT_PAGE_UP:int = 1033
const INT_PAGE_DOWN:int = 1034

# 0 	48 	0x30 	1048 	2048
# 1 	49 	0x31 	1049 	2049
# 2 	50 	0x32 	1050 	2050
# 3 	51 	0x33 	1051 	2051
# 4 	52 	0x34 	1052 	2052
# 5 	53 	0x35 	1053 	2053
# 6 	54 	0x36 	1054 	2054
# 7 	55 	0x37 	1055 	2055
# 8 	56 	0x38 	1056 	2056
# 9 	57 	0x39 	1057 	2057
const INT_ALPHA_0:int = 1048
const INT_ALPHA_1:int = 1049
const INT_ALPHA_2:int = 1050
const INT_ALPHA_3:int = 1051
const INT_ALPHA_4:int = 1052
const INT_ALPHA_5:int = 1053
const INT_ALPHA_6:int = 1054
const INT_ALPHA_7:int = 1055
const INT_ALPHA_8:int = 1056
const INT_ALPHA_9:int = 1057

# A 	65 	0x41 	1065 	2065
# B 	66 	0x42 	1066 	2066
# C 	67 	0x43 	1067 	2067
# D 	68 	0x44 	1068 	2068
# E 	69 	0x45 	1069 	2069
# F 	70 	0x46 	1070 	2070
# G 	71 	0x47 	1071 	2071
# H 	72 	0x48 	1072 	2072
# I 	73 	0x49 	1073 	2073
# J 	74 	0x4A 	1074 	2074
# K 	75 	0x4B 	1075 	2075
# L 	76 	0x4C 	1076 	2076
# M 	77 	0x4D 	1077 	2077
# N 	78 	0x4E 	1078 	2078
# O 	79 	0x4F 	1079 	2079
# P 	80 	0x50 	1080 	2080
# Q 	81 	0x51 	1081 	2081
# R 	82 	0x52 	1082 	2082
# S 	83 	0x53 	1083 	2083
# T 	84 	0x54 	1084 	2084
# U 	85 	0x55 	1085 	2085
# V 	86 	0x56 	1086 	2086
# W 	87 	0x57 	1087 	2087
# X 	88 	0x58 	1088 	2088
# Y 	89 	0x59 	1089 	2089
# Z 	90 	0x5A 	1090 	2090
const INT_KEY_A:int = 1065
const INT_KEY_B:int = 1066
const INT_KEY_C:int = 1067
const INT_KEY_D:int = 1068
const INT_KEY_E:int = 1069
const INT_KEY_F:int = 1070
const INT_KEY_G:int = 1071
const INT_KEY_H:int = 1072
const INT_KEY_I:int = 1073
const INT_KEY_J:int = 1074
const INT_KEY_K:int = 1075
const INT_KEY_L:int = 1076
const INT_KEY_M:int = 1077
const INT_KEY_N:int = 1078
const INT_KEY_O:int = 1079
const INT_KEY_P:int = 1080
const INT_KEY_Q:int = 1081
const INT_KEY_R:int = 1082
const INT_KEY_S:int = 1083
const INT_KEY_T:int = 1084
const INT_KEY_U:int = 1085
const INT_KEY_V:int = 1086
const INT_KEY_W:int = 1087
const INT_KEY_X:int = 1088
const INT_KEY_Y:int = 1089
const INT_KEY_Z:int = 1090

const INT_KEY_A_CHAR:String="A"
const INT_KEY_B_CHAR:String="B"
const INT_KEY_C_CHAR:String="C"
const INT_KEY_D_CHAR:String="D"
const INT_KEY_E_CHAR:String="E"
const INT_KEY_F_CHAR:String="F"
const INT_KEY_G_CHAR:String="G"
const INT_KEY_H_CHAR:String="H"
const INT_KEY_I_CHAR:String="I"
const INT_KEY_J_CHAR:String="J"
const INT_KEY_K_CHAR:String="K"
const INT_KEY_L_CHAR:String="L"
const INT_KEY_M_CHAR:String="M"
const INT_KEY_N_CHAR:String="N"
const INT_KEY_O_CHAR:String="O"
const INT_KEY_P_CHAR:String="P"
const INT_KEY_Q_CHAR:String="Q"
const INT_KEY_R_CHAR:String="R"
const INT_KEY_S_CHAR:String="S"
const INT_KEY_T_CHAR:String="T"
const INT_KEY_U_CHAR:String="U"
const INT_KEY_V_CHAR:String="V"
const INT_KEY_W_CHAR:String="W"
const INT_KEY_X_CHAR:String="X"
const INT_KEY_Y_CHAR:String="Y"
const INT_KEY_Z_CHAR:String="Z"


# Numpad0 	96 	0x60 	1096 	2096
# Numpad1 	97 	0x61 	1097 	2097
# Numpad2 	98 	0x62 	1098 	2098
# Numpad3 	99 	0x63 	1099 	2099
# Numpad4 	100 	0x64 	1100 	2100
# Numpad5 	101 	0x65 	1101 	2101
# Numpad6 	102 	0x66 	1102 	2102
# Numpad7 	103 	0x67 	1103 	2103
# Numpad8 	104 	0x68 	1104 	2104
# Numpad9 	105 	0x69 	1105 	2105
const INT_NUMPAD_0:int = 1096
const INT_NUMPAD_1:int = 1097
const INT_NUMPAD_2:int = 1098
const INT_NUMPAD_3:int = 1099
const INT_NUMPAD_4:int = 1100
const INT_NUMPAD_5:int = 1101
const INT_NUMPAD_6:int = 1102
const INT_NUMPAD_7:int = 1103
const INT_NUMPAD_8:int = 1104
const INT_NUMPAD_9:int = 1105


# Multiply 	106 	0x6A 	1106 	2106
# Add 	107 	0x6B 	1107 	2107
# Subtract 	109 	0x6D 	1109 	2109
# Decimal 	110 	0x6E 	1110 	2110
# Divide 	111 	0x6F 	1111 	2111
const INT_NUMPAD_MULTIPLY   :int = 1106
const INT_NUMPAD_ADD        :int = 1107
const INT_NUMPAD_SUBTRACT   :int = 1109
const INT_NUMPAD_DIVIDE     :int = 1111

const INT_NUMPAD_DECIMAL    :int = 1110

# F1 	112 	0x70 	1112 	2112
# F2 	113 	0x71 	1113 	2113
# F3 	114 	0x72 	1114 	2114
# F4 	115 	0x73 	1115 	2115
# F5 	116 	0x74 	1116 	2116
# F6 	117 	0x75 	1117 	2117
# F7 	118 	0x76 	1118 	2118
# F8 	119 	0x77 	1119 	2119
# F9 	120 	0x78 	1120 	2120
# F10 	121 	0x79 	1121 	2121
# F11 	122 	0x7A 	1122 	2122
# F12 	123 	0x7B 	1123 	2123
const INT_F1    :int = 1112
const INT_F2    :int = 1113
const INT_F3    :int = 1114
const INT_F4    :int = 1115
const INT_F5    :int = 1116
const INT_F6    :int = 1117
const INT_F7    :int = 1118
const INT_F8    :int = 1119
const INT_F9    :int = 1120
const INT_F10   :int = 1121
const INT_F11   :int = 1122
const INT_F12   :int = 1123

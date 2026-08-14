class_name S2WListenToSingleNES
extends Node

signal on_nes_as_text_input(text: String, is_pressing: bool)
signal on_nes_arrow_up_pressed_value(value:bool)
signal on_nes_arrow_right_pressed_value(value:bool)
signal on_nes_arrow_down_pressed_value(value:bool)
signal on_nes_arrow_left_pressed_value(value:bool)
signal on_nes_a_pressed_value(value: bool)
signal on_nes_b_pressed_value(value: bool)
signal on_nes_menu_left_pressed_value(value: bool)
signal on_nes_menu_right_pressed_value(value: bool)

# 1281 1000> 2281 500> 1282 1000> 2282 500> 1283 1000> 2283 500> 1284 1000> 2284 500> 1285 1000> 2285 500> 1286 1000> 2286 500> 1287 1000> 2287 500> 1288 1000> 2288 500>




@export_group("S2W Official integer")
@export var button_up:int = 1281
@export var button_right:int = 1282
@export var button_down:int = 1283
@export var button_left:int = 1284
@export var button_a:int = 1285
@export var button_b:int = 1286
@export var button_menu_left:int = 1287
@export var button_menu_right:int = 1288

@export_group("As string / boolean format")
@export var button_up_name:Array[String] = ["NES_ARROW_UP"]
@export var button_right_name:Array[String] = ["NES_ARROW_RIGHT"]
@export var button_down_name:Array[String] = ["NES_ARROW_DOWN"]
@export var button_left_name:Array[String] = ["NES_ARROW_LEFT"]
@export var button_a_name:Array[String] = ["NES_BUTTON_A"]
@export var button_b_name:Array[String] = ["NES_BUTTON_B"]
@export var button_menu_left_name:Array[String] = ["NES_MENU_LEFT"]
@export var button_menu_right_name:Array[String] = ["NES_MENU_RIGHT"]


# Up Arrow	1281	2281
# Right Arrow	1282	2282
# Down Arrow	1283	2283
# Left Arrow	1284	2284
# A Button	1285	2285
# B Button	1286	2286
# Menu Left	1287	2287
# Menu Right	1288	2288


func push_text_and_parse_to_int(text: String) -> void:
	if text.is_valid_int():
		var value = int(text)
		push_in_integer(value)

func push_in_integer(value: int) -> void:
	
	if value==button_up:
		on_nes_arrow_up_pressed_value.emit(true)
		_notify_as_text_pressed(button_up_name, true)
	elif value==button_up+1000:
		on_nes_arrow_up_pressed_value.emit(false)
		_notify_as_text_pressed(button_up_name, false)
	elif value==button_right:
		on_nes_arrow_right_pressed_value.emit(true)
		_notify_as_text_pressed(button_right_name, true)
	elif value==button_right+1000:
		on_nes_arrow_right_pressed_value.emit(false)
		_notify_as_text_pressed(button_right_name, false)
	elif value==button_down:
		on_nes_arrow_down_pressed_value.emit(true)
		_notify_as_text_pressed(button_down_name, true)
	elif value==button_down+1000:
		on_nes_arrow_down_pressed_value.emit(false)
		_notify_as_text_pressed(button_down_name, false)
	elif value==button_left:
		on_nes_arrow_left_pressed_value.emit(true)
		_notify_as_text_pressed(button_left_name, true)
	elif value==button_left+1000:
		on_nes_arrow_left_pressed_value.emit(false)
		_notify_as_text_pressed(button_left_name, false)
	elif value==button_a:
		on_nes_a_pressed_value.emit(true)
		_notify_as_text_pressed(button_a_name, true)
	elif value==button_a+1000:
		on_nes_a_pressed_value.emit(false)
		_notify_as_text_pressed(button_a_name, false)
	elif value==button_b:
		on_nes_b_pressed_value.emit(true)
		_notify_as_text_pressed(button_b_name, true)
	elif value==button_b+1000:
		on_nes_b_pressed_value.emit(false)
		_notify_as_text_pressed(button_b_name, false)
	elif value==button_menu_left:
		on_nes_menu_left_pressed_value.emit(true)
		_notify_as_text_pressed(button_menu_left_name, true)
	elif value==button_menu_left+1000:
		on_nes_menu_left_pressed_value.emit(false)
		_notify_as_text_pressed(button_menu_left_name, false)
	elif value==button_menu_right:
		on_nes_menu_right_pressed_value.emit(true)
		_notify_as_text_pressed(button_menu_right_name, true)
	elif value==button_menu_right+1000:
		on_nes_menu_right_pressed_value.emit(false)
		_notify_as_text_pressed(button_menu_right_name, false)
	

func _notify_as_text_pressed(text: Array[String], is_pressing: bool) -> void:
	for t in text:
		on_nes_as_text_input.emit(t, is_pressing)

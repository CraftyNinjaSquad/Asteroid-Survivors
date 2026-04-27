extends Node

var currency = 0
var max_health = 100.0
var health = 100.0
var max_fuel = 100.0
var fuel = 100.0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("full_screen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)

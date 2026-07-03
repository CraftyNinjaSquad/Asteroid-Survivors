extends Node

#player variables
var max_health = 100.0
var health = 100.0
var max_fuel = 100.0
var fuel = 100.0
var fuel_depletion = 5.0
var target_speed = 5.0
var acceleration = 2.0
var fire_rate = .5
var damping = .2
var currency_mult = 1.0

#shop variables
var currency = 0.0
var quota = 100
var quota_paid = 0
var fuel_cost = 10.0
var repair_cost = 10.0
var reroll_cost = 5.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("full_screen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)

func apply_upgrade(upgrade: Upgrade):
	match upgrade.stat_name:
		"max_health":
			max_health += upgrade.value
		
		"max_fuel":
			max_fuel += upgrade.value
		
		"fuel_depletion":
			fuel_depletion *= upgrade.value
		
		"target_speed":
			target_speed *= upgrade.value
		
		"acceleration":
			acceleration *= upgrade.value
		
		"fire_rate":
			fire_rate *= upgrade.value
		
		"currency_mult":
			currency_mult = roundf(currency_mult * upgrade.value)

## Reset game
func reset_game():
	## reset variables to default values.
	max_health = 100.0
	health = 100.0
	max_fuel = 100.0
	fuel = 100.0
	fuel_depletion = 5.0
	target_speed = 5.0
	acceleration = 2.0
	fire_rate = .5
	damping = .2
	currency_mult = 1.0
	
	currency = 0.0
	quota = 100
	quota_paid = 0
	fuel_cost = 10.0
	repair_cost = 10.0
	reroll_cost = 5.0

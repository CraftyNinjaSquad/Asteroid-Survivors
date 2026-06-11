extends Control

@onready var fuel_cost_label = $ColorRect/BottomButtons/Refuel/RefuelPrice
@onready var repair_cost_label = $ColorRect/BottomButtons/Repair/RepairPrice
@onready var quota_label = $ColorRect/BottomButtons/Quota/QuotaPrice
@onready var reroll_cost_label = $ColorRect/SideButtons/RerollPrice

var fuel_price = 10.0
var repair_cost = 5.0
var reroll_cost = 5.0
var current_quota = 100.0
var quota_paid = 0.0
var quota_cost = current_quota / 10.0

func _ready() -> void:
	pass

func _on_refuel_button_pressed() -> void:
	if globals.currency >= fuel_price:
		globals.currency -= fuel_price
		globals.fuel = globals.max_fuel
		fuel_price += 5.0
		fuel_cost_label.text = str(fuel_price)
	else:
		return

func _on_repair_button_pressed() -> void:
	if globals.currency >= repair_cost:
		globals.currency -= repair_cost
		globals.health = globals.max_health
		repair_cost += 5.0
		repair_cost_label.text = str(repair_cost)
	else:
		return

func _on_pay_button_pressed() -> void:
	if globals.currency >= quota_cost:
		globals.currency -= quota_cost
		quota_paid += quota_cost
		if quota_paid >= current_quota:
			current_quota += roundf(current_quota * 1.5)
			quota_paid = 0.0
			globals.fuel = globals.max_fuel
			globals.health = globals.max_health
		quota_label.text = str(quota_paid," / ",current_quota)
	else:
		return

func _on_reroll_button_pressed() -> void:
	if globals.currency >= reroll_cost:
		globals.currency -= reroll_cost
		reroll_cost += 5.0
		
		
		
	else:
		return

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	queue_free()

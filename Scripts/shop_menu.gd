extends CanvasLayer

@export var Shop_manager = Node
@export var upgrade_option: PackedScene

@onready var fuel_cost_label = $ColorRect/BottomButtons/Refuel/RefuelPrice
@onready var repair_cost_label = $ColorRect/BottomButtons/Repair/RepairPrice
@onready var quota_label = $ColorRect/BottomButtons/Quota/QuotaPrice
@onready var reroll_cost_label = $ColorRect/SideButtons/RerollPrice
@onready var available_upgrades = $ColorRect/Upgrades

var fuel_price = globals.fuel_cost
var repair_cost = globals.repair_cost
var reroll_cost = globals.reroll_cost
var quota_cost = globals.quota / 10.0
var shop


func _ready() -> void:
	fuel_cost_label.text = str(fuel_price)
	repair_cost_label.text = str(repair_cost)
	quota_label.text = str(globals.quota_paid," / ",globals.quota)
	reroll_cost_label.text = str(reroll_cost)
	open_shop()

func open_shop():
	Shop_manager.generate_shop()
	
	for child in available_upgrades.get_children():
		child.queue_free()
	
	for upgrade in Shop_manager.current_offers:
		var item = upgrade_option.instantiate()
		item.setup(upgrade)
		item.item_selected.connect(_on_item_selected)
		available_upgrades.add_child(item)

func _on_item_selected(upgrade: Upgrade):
	if globals.currency < upgrade.cost:
		return
	
	globals.currency -= upgrade.cost
	globals.apply_upgrade(upgrade)

func _on_refuel_button_pressed() -> void:
	if globals.currency >= fuel_price and globals.fuel < globals.max_fuel:
		globals.currency -= fuel_price
		globals.fuel = globals.max_fuel
		globals.fuel_cost += 5.0
		fuel_cost_label.text = str(globals.fuel_cost)
	else:
		return

func _on_repair_button_pressed() -> void:
	if globals.currency >= repair_cost and globals.health < globals.max_health:
		globals.currency -= repair_cost
		globals.health = globals.max_health
		globals.repair_cost += 5.0
		repair_cost_label.text = str(globals.repair_cost)
	else:
		return

func _on_pay_button_pressed() -> void:
	if globals.currency >= quota_cost:
		globals.currency -= quota_cost
		globals.quota_paid += quota_cost
		if globals.quota_paid >= globals.quota:
			globals.quota += roundf(globals.quota * 1.5)
			globals.quota_paid = 0.0
			globals.fuel = globals.max_fuel
			globals.health = globals.max_health
		quota_label.text = str(globals.quota_paid," / ",globals.quota)
	else:
		return

func _on_reroll_button_pressed() -> void:
	if globals.currency >= reroll_cost:
		globals.currency -= reroll_cost
		globals.reroll_cost += 5.0
		reroll_cost_label.text = str(globals.reroll_cost)
		open_shop()
	else:
		return

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()

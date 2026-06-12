extends Area3D

var isOpen: bool = false
const shop_menu = preload("res://Asteroid-Survivors/Scenes/shop_menu.tscn")
var shop

func _process(delta: float) -> void:
	if globals.fuel < (globals.max_fuel/2):
		isOpen = true
	else:
		isOpen = false

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player"):
		if isOpen:
			shop = shop_menu.instantiate()
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().current_scene.add_child(shop)

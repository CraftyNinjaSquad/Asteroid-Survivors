extends Area3D

var value = globals.currency_mult

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player"):
		globals.currency += value
		queue_free()

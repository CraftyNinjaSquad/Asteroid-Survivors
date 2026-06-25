extends Area3D

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player"):
		globals.currency += globals.currency_mult
		queue_free()

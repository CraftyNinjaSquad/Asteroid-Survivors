extends TextureProgressBar

func _process(delta: float) -> void:
	value = globals.health
	max_value = globals.max_health

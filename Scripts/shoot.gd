extends RayCast3D

const LAZER = preload("res://Asteroid-Survivors/Scenes/Lazer.tscn")
var can_shoot = true
var fire_rate = .2

func _process(delta: float) -> void:
	shoot()

func shoot():
	if Input.is_action_pressed("shoot") and can_shoot == true:
		var lazer_instance = LAZER.instantiate()
		get_tree().current_scene.add_child(lazer_instance)
		lazer_instance.position = self.global_position
		lazer_instance.transform.basis = self.global_transform.basis
		can_shoot = false
		await get_tree().create_timer(fire_rate).timeout
		can_shoot = true

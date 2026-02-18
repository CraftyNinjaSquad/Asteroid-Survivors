extends Marker3D

const asteroid = preload("res://Asteroid-Survivors/Scenes/Asteroid.tscn")

var spawn_radius = 30

func _ready() -> void:
	Spawn_enemy()


func Spawn_enemy():
	var theta = 2 * PI * randf()
	var phi = PI * randf()   
	# Convert to cartesian
	var x = sin(phi) * cos(theta) * spawn_radius
	var y = sin(phi) * sin(theta) * spawn_radius
	var z = cos(phi) * spawn_radius
	var spawn_pos = Vector3(x,y,z)
	
	for i in range(3):
		var asteroid_instance = asteroid.instantiate()
		asteroid_instance.position = spawn_pos
		get_tree().current_scene.add_child(asteroid_instance)
	await get_tree().create_timer(5).timeout
	Spawn_enemy()

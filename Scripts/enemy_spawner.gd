extends Marker3D

const asteroid = preload("res://Asteroid-Survivors/Scenes/Asteroid.tscn")

var spawn_radius = 30
var spawn_rate = 5.00
var spawn_amount = 3
var counter = 0

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
	
	for i in range(spawn_amount):
		var asteroid_instance = asteroid.instantiate()
		asteroid_instance.position = spawn_pos
		get_tree().current_scene.add_child.call_deferred(asteroid_instance)
	await get_tree().create_timer(spawn_rate, false).timeout
	if spawn_rate > 2.0:
		spawn_rate -= 0.01
	if spawn_rate == 2:
		if counter < 5:
			counter =+ 1
		else:
			spawn_amount += 1
			counter = 0
	Spawn_enemy()

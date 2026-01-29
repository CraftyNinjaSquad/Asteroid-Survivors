extends Area3D

@onready var rock = $MeshInstance3D
@onready var rockcollide = $CollisionShape3D

const lazer = preload("res://Asteroid-Survivors/Scenes/Lazer.tscn")
const asteroid = preload("res://Asteroid-Survivors/Scenes/Asteroid.tscn")

var velocity = Vector3(0,0,0)
var size = randi_range(1,4)
var speed = randf_range(0.1,0.75)

func  _ready() -> void:
	velocity.x = randf_range(0.0,1.0)
	velocity.y = randf_range(0.0,1.0)
	velocity.z = randf_range(0.0,1.0)
	
	self.scale *= size
	rock.scale *= size
	rockcollide.scale *= size
	print(size)
	
	
func _physics_process(delta: float) -> void:
	position += transform.basis * velocity * speed * delta


func destroy():
	var asteroid_instance = asteroid.instantiate()
	if size > 1:
		size -= 1
		asteroid_instance.size = size
		for i in randi_range(2,4):
			asteroid_instance.position = self.position
			get_tree().current_scene.add_child(asteroid_instance)
			
	queue_free()
	

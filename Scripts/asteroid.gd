extends Area3D

@onready var rock = $MeshInstance3D
@onready var rockcollide = $CollisionShape3D

const lazer = preload("res://Asteroid-Survivors/Scenes/Lazer.tscn")
const asteroid = preload("res://Asteroid-Survivors/Scenes/Asteroid.tscn")
const ohre = preload("res://Asteroid-Survivors/Scenes/ohre.tscn")

const despawn_range = 75

var player
var direction = Vector3(0,0,0)
var size = randi_range(1,4)
var speed = randf_range(0.1,0.75)
var rotating = Vector3(0,0,0)
var canHit = false
var player_damage = 5
var velocity_vector: Vector3 = Vector3.ZERO

func  _ready() -> void:
	direction.x = randf_range(0.0,1.0)
	direction.y = randf_range(0.0,1.0)
	direction.z = randf_range(0.0,1.0)
	
	rotating.x = randf_range(0.0,0.01)
	rotating.y = randf_range(0.0,0.01)
	rotating.z = randf_range(0.0,0.01)
	player = get_tree().current_scene.get_node("Player")
	
	self.scale *= size
	rock.scale *= size
	rockcollide.scale *= size
	
	await get_tree().create_timer(0.1).timeout
	canHit = true
	
func _physics_process(delta: float) -> void:
	velocity_vector = direction * speed * delta
	rotate_x(rotating.x)
	rotate_y(rotating.y)
	rotate_z(rotating.z)
	var player_pos = player.global_position
	position += velocity_vector
	
	
	if self.global_position.distance_to(player_pos) > despawn_range:
		queue_free()
		
func destroy():
	if canHit:
		var asteroid_instance = asteroid.instantiate()
		var ohre_instance = ohre.instantiate()
		if size > 1:
			size -= 1
			asteroid_instance.size = size
			for i in randi_range(2,4):
				asteroid_instance.position = self.position
				get_tree().current_scene.add_child(asteroid_instance)
		
		ohre_instance.position = self.position
		get_tree().current_scene.add_child(ohre_instance)
		queue_free()

func _on_player_entered(area: Area3D) -> void:
	if area.is_in_group("Player"):
		if canHit:
			globals.health -= player_damage * size
			destroy()

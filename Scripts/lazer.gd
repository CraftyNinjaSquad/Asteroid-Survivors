extends Node3D

var velocity = Vector3(0,1,0)
const SPEED = 100

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position += transform.basis * Vector3(0,0,-SPEED) * delta

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("asteroids"):
		area.destroy()
		print("hit")
		queue_free()

extends Control

@onready var Fuel_Bar = $FuelBar
@onready var Health_bar = $HealthBar
@onready var FPoV = $"../../FPoV"
@onready var RPoV = $"../../RPoV"
@onready var compass = $SubViewportContainer/SubViewport/Compass

@export var player: Node3D
var target: Node3D

var current_camera

func _ready() -> void:
	target = get_tree().current_scene.get_node("star")

func _process(_delta: float) -> void:
	current_camera = get_viewport().get_camera_3d()
	if current_camera == FPoV:
		Fuel_Bar.position.x = 479.0
		Fuel_Bar.position.y = 400.0
		Fuel_Bar.rotation_degrees = -60.0
		
		Health_bar.position.x = 147.0
		Health_bar.position.y = 412.0
		Health_bar.rotation_degrees = 240.0
		
	else:
		Fuel_Bar.position.x = 844.0
		Fuel_Bar.position.y = 348.0
		Fuel_Bar.rotation_degrees = -90.0
		
		Health_bar.position.x = -222.0
		Health_bar.position.y = 348.0
		Health_bar.rotation_degrees = 270.0
		
	#if not player or target:
		#return
		
	#var direction = (target.global_position - player.global_position).normalized()
	#
	#var player_forward = -player.get_global_transform().basis.z
	#
	#var angle = atan2(direction.y, direction.x) - atan2(player_forward.y, player_forward.x)
	#
	#
	#compass.look_at_from_position(player_forward, target.global_position, Vector3.FORWARD)
	#$SubViewportContainer/SubViewport/Camera3D.position = compass.position
	#$SubViewportContainer/SubViewport/Camera3D.position.z += 1.8
	
	var player_pos = player.global_transform.origin
	var target_pos = target.global_transform.origin
	
	var dir = (target_pos - player_pos).normalized()
	
	dir = player.global_transform.basis.inverse() * dir
	compass.look_at(compass.global_transform.origin + dir, Vector3.UP, false)
	
	if current_camera == RPoV:
		$SubViewportContainer/SubViewport/Camera3D.position.z = -1.88
		$SubViewportContainer/SubViewport/Camera3D.rotation_degrees.y = 180
	else:
		$SubViewportContainer/SubViewport/Camera3D.position.z = 1.88
		$SubViewportContainer/SubViewport/Camera3D.rotation_degrees.y = 0

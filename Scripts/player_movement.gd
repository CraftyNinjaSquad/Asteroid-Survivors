extends CharacterBody3D

@onready var fpov: Camera3D = $FPoV
@onready var tpov: Camera3D = $TPoV
@onready var rpov: Camera3D = $RPoV

#const SPEED = 5.0
const CAMERA_SENS = 0.003

@export var acceleration = 2.0
@export var target_speed = 5.0
@export var fuel_depletion = 5.0
@export var damping = 0.1

var velocity_vector: Vector3 = Vector3.ZERO
var spawn_radius = 30
var mouse_movement = Vector2.ZERO

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
#func fuel_deplete():
	#if globals.fuel > 0:
		#globals.fuel -= fuel_depletion


func _input(event):
	if event.is_action_pressed("quit"): get_tree().quit()
	
	#if event.is_action_pressed("thrusters"):
		##pass
		#forward_speed = target_speed
		#if globals.fuel > 0:
			#globals.fuel -= fuel_depletion
	#if event.is_action_released("thrusters"):
		#forward_speed = 0.0
	
	if event.is_action_pressed("pov_switch"):
		
		if fpov.current:
			fpov.current = false
			tpov.current = true
			rpov.current = false
		elif tpov.current:
			fpov.current = false
			tpov.current = false
			rpov.current = true
		elif rpov.current:
			fpov.current = true
			tpov.current = false
			rpov.current = false
			
		
	if event is InputEventMouseMotion:
		#left right
		rotate_object_local(Vector3(0,1,0), -event.relative.x * CAMERA_SENS) 
		#up down
		rotate_object_local(Vector3(1,0,0), -event.relative.y * CAMERA_SENS) 
		
		mouse_movement = event.relative
		#rotation.x = lerp(rotation.x, rotation. x - event.relative.y, CAMERA_SENS)
		#limit vertical rotation to prevent camera glitching.
		#if rotation.x > 1.55:
			#rotation.x = 1.55
		#if rotation.x < -1.55:
			#rotation.x = -1.55

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction = Vector3(rotation.x,rotation.y,rotation.z)
	#if direction:
		#velocity += direction * forward_speed * delta
		#print(velocity)
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if mouse_movement > Vector2(0.0,0.0):
		if globals.fuel > 0:
			globals.fuel -= fuel_depletion * 0.33 * delta
			mouse_movement = Vector2.ZERO
	
	if Input.is_action_pressed("thrusters"):
		if globals.fuel > 0:
			var forward = -transform.basis.z
			velocity_vector += forward * acceleration * delta
			globals.fuel -= fuel_depletion * delta
		
	if damping > 0.0:
		velocity_vector = velocity_vector.lerp(Vector3.ZERO, damping * delta)
		
	if velocity_vector.length() > target_speed:
		velocity_vector = velocity_vector.normalized() * target_speed
		
	velocity = velocity_vector
	move_and_slide()

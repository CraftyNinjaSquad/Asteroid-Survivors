extends CharacterBody3D

@onready var fpov: Camera3D = $FPoV
@onready var tpov: Camera3D = $"3PoV"

#const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const CAMERA_SENS = 0.003


var acceleration = 1.0
var forward_speed = 1.0
var target_speed = 5.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event.is_action_pressed("quit"): get_tree().quit()
	
	if event.is_action_pressed("pov_switch"):
		if fpov.current:
			fpov.current = false
			tpov.current = true
		else:
			fpov.current = true
			tpov.current = false
		
	if event is InputEventMouseMotion:
		#left right
		rotation.y = lerp(rotation.y,rotation.y - event.relative.x, CAMERA_SENS)
		#up down
		rotation.x = lerp(rotation.x, rotation. x - event.relative.y, CAMERA_SENS)
		#limit vertical rotation to prevent camera glitching.
		if rotation.x > 1.55:
			rotation.x = 1.55
		if rotation.x < -1.55:
			rotation.x = -1.55
		

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
		
	
	forward_speed = lerp(forward_speed,target_speed,acceleration * delta)
	velocity = -transform.basis.z * forward_speed
	move_and_slide()

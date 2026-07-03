extends CanvasLayer

@onready var pause_buttons = $ColorRect/MainPauseButtons
@onready var confirm_window = $ColorRect/Confirmation
@onready var options_menu = $ColorRect/Options

@onready var general_options = $ColorRect/Options/GeneralOptions
@onready var video_options = $ColorRect/Options/VideoOptions
@onready var audio_options = $ColorRect/Options/AudioOptions

var action

# Main pause functions
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		queue_free()
		get_viewport().set_input_as_handled()
		get_tree().paused = false

func _on_resume_button_pressed():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()

func _on_reset_button_pressed():
	pause_buttons.visible = false
	confirm_window.visible = true
	action = "RESET"

func _on_options_button_pressed():
	pause_buttons.visible = false
	options_menu.visible = true

func _on_main_button_pressed():
	pause_buttons.visible = false
	confirm_window.visible = true
	action = "MAIN_MENU"

func _on_exit_button_pressed():
	pause_buttons.visible = false
	confirm_window.visible = true
	action = "EXIT"
	
func _on_yes_button_pressed():
	if action:
		match action:
			"RESET":
				globals.reset_game()
				get_tree().paused = false
				get_tree().reload_current_scene()
			"MAIN_MENU":
				pass
			"EXIT":
				get_tree().quit()
	else:
		pause_buttons.visible = true
		confirm_window.visible = false
	
func _on_no_button_pressed():
	pause_buttons.visible = true
	confirm_window.visible = false


## options menu functions

# menu selectors:
func _on_general_button_pressed():
	general_options.visible = true
	video_options.visible = false
	audio_options.visible = false

func _on_video_button_pressed():
	general_options.visible = false
	video_options.visible = true
	audio_options.visible = false

func _on_audio_button_pressed():
	general_options.visible = false
	video_options.visible = false
	audio_options.visible = true

func _on_back_button_pressed():
	pause_buttons.visible = true
	options_menu.visible = false

# general options:

# video Options:

# audio Options:

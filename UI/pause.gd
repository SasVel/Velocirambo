extends Control

func _input(event):
	#TODO
	#This probably has to open up the pause menu later on. Temporary solution.
	if event.is_action_pressed("ESC"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if get_tree().paused else Input.MOUSE_MODE_HIDDEN
		get_tree().paused = !get_tree().paused

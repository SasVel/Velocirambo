extends Node3D


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):

	#TODO
	#This probably has to open up the pause menu later on
	if event.is_action_pressed("ESC"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event.is_action_pressed("Leftclick"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

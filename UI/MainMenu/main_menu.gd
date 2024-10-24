extends Node3D

func _ready():
	Music.play(Music.Tracks.Anky)
	get_tree().paused = false

#func _input(event):
	#if Input.get_vector("joy_camera_down", "joy_camera_up", "joy_camera_left", "joy_camera_right", 0.9) > Vector2.ZERO: 
		#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		#GameInfo.data.usingController = true
	#elif event is InputEventMouseButton or InputEventMouseMotion:
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		#GameInfo.data.usingController = false

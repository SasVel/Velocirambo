extends Node3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Music.play(Music.Tracks.Anky)
	Spawn.isSpawningPickups = true

func _input(event):
	if event.is_action_pressed("Leftclick"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

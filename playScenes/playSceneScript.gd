extends Node3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Spawn.isSpawningPickups = true
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("Shoot") && Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event is InputEventJoypadButton or InputEventJoypadMotion:
		GameInfo.data.usingController = true
	elif event is InputEventMouseButton or InputEventMouseMotion:
		GameInfo.data.usingController = false

func _exit_tree():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Spawn.isSpawningPickups = false
	GameInfo.reset.emit()

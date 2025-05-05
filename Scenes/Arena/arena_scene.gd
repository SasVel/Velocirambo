extends Node3D

@export var canvasUI : CanvasLayer

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	get_tree().paused = false
	await get_tree().physics_frame

	Spawn.isSpawningPickups = true
	announce("ANKY_NAME", "ANKY_DESC")

func _input(event):
	if event.is_action_pressed("ui_accept") && Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _exit_tree():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Spawn.isSpawningPickups = false
	GameInfo.reset.emit()

func announce(title : String, desc : String):
	UI.show_announce_label(canvasUI, title, desc)

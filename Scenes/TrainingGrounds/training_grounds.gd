extends Node3D

@export var camController : CameraController

func _ready():
	UI.change_mode(UIHelper.Modes.Interact)

func _on_interact_component_activated():
	camController.set_current_camera(1)

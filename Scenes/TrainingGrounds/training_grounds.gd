extends Node3D

@export var camController : CameraController

func _ready():
	UI.change_mode(UIHelper.Modes.Interact)

func _on_level_interact_component_activated(_player):
	camController.set_current_camera(1)

func _on_equip_interact_component_activated(_player):
	camController.set_current_camera(2)

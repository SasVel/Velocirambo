extends Node3D
class_name InteractObject

@export var camController : CameraController
@export var activeCameraIdx : int

@export var rootUI : Control

var playerRef : Player

func _ready():
	rootUI.visible = false

func _on_back_btn_pressed():
	camController.set_current_camera(0)
	playerRef.isControlled = true
	rootUI.visible = false
	UI.change_to_last_mode()

func _on_interact_component_activated(player:Player) -> void:
	playerRef = player
	playerRef.isControlled = false
	UI.change_mode(UI.Modes.Free)
	await camController.set_current_camera(activeCameraIdx)
	rootUI.visible = true

func _on_interact_component_deactivated(_player:Player) -> void:
	pass

extends Node3D

@export var scaleTween : ScaleTween

func _on_area_3d_body_entered(_body:Node3D):
	UI.change_mode(UI.Modes.Battle)

func _on_area_3d_body_exited(_body:Node3D):
	UI.change_mode(UI.Modes.Interact)


func _on_dummy_hurtbox_hurtbox_hit(_dmg:float, _hitVector:Vector3):
	scaleTween.activate()

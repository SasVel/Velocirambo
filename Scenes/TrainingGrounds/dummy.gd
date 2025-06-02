extends Node3D

func _on_area_3d_body_entered(body:Node3D):
	UI.change_mode(UI.Modes.Battle)

func _on_area_3d_body_exited(body:Node3D):
	UI.change_mode(UI.Modes.Interact)

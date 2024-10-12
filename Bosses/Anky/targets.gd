extends Node3D

var isAiming : bool
var enabled : bool = true :
	set(val):
		for target in get_children():
			target.monitorable = val
			if isAiming: target.visible = val
		enabled = val

func _input(event):
	if event.is_action_pressed("Aim"):
		isAiming = true
		for target in get_children():
			target.visible = true
	elif event.is_action_released("Aim"):
		isAiming = false
		for target in get_children():
			target.visible = false

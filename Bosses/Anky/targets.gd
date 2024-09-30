extends Node3D

var enabled : bool = true :
	set(val):
		for target in get_children():
			target.monitorable = val
			target.visible = val
		enabled = val

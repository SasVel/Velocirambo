extends Node3D

func _ready():
	GameInfo.game_won.connect(func(): enable = true)

var enable : bool = false :
	set(val):
		for emitter in get_children():
			emitter.emitting = val
		enable = val

extends Node3D

func _ready():
	GameData.game_won.connect(func(): enable = true)

var enable : bool = false :
	set(val):
		for emitter in get_children():
			emitter.emitting = val
		enable = val

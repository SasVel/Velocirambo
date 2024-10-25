extends Node3D

func _ready():
	Music.play(Music.Tracks.Anky)
	get_tree().paused = false

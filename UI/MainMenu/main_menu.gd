extends Node3D

func _ready():
	Music.play(Music.Tracks.Anky)
	get_tree().paused = false
	SteamStuff.unlock_ach(SteamStuff.Ach.START_GAME)

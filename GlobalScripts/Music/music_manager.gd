extends Node

enum Tracks{
	Anky
}

@onready var currentPlayer : AudioStreamPlayer
@onready var currentTrack = Tracks.Anky :
	set(val):
		match val:
			Tracks.Anky:
				currentPlayer = $Anky
		currentTrack = val

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(GameInfo.data.mainVol))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(GameInfo.data.musicVol))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(GameInfo.data.sfxVol))


func play(track : Tracks):
	if currentPlayer != null: currentPlayer.stop()
	currentTrack = track
	currentPlayer.play()

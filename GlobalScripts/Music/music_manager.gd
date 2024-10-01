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

func play(track : Tracks):
	if currentPlayer != null: currentPlayer.stop()
	currentTrack = track
	currentPlayer.play()

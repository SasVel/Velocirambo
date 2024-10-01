extends Node

##For managing sound effects. Provides an interface for playing sounds,
##as well as playing sounds for fired signals. [u]Only for AudioStreamPlayers.[/u]

@onready var runStream = $Run

enum {
	Gunshot,
	Run,
	RaptorRoar,
	Beer,
	Crowd
}

func play(sound):
	match sound:
		Gunshot: $Gunshot.play()
		Run: $Run.play()
		RaptorRoar: $RaptorRoar.play()
		Beer: $Beer.play()
		Crowd: $Crowd.play()

extends Node

##For managing sound effects. Provides an interface for playing sounds,
##as well as playing sounds for fired signals. [u]Only for AudioStreamPlayers.[/u]

@onready var runStream = $Run

func _ready():
	GameData.game_won.connect(game_won)
	GameData.reset.connect(reset)

func game_won():
	play(Crowd)

func reset():
	$Crowd.stop()

enum {
	Gunshot,
	Run,
	RaptorRoar,
	Beer,
	Crowd,
	RaptorHurt
}

func play(sound):
	match sound:
		Gunshot: $Gunshot.play()
		Run: $Run.play()
		Beer: $Beer.play()
		Crowd: $Crowd.play()
		RaptorRoar: $RaptorRoar.play()
		RaptorHurt: $RaptorHurt.play()

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
	RaptorHurt,
	CasingsDrop,
	Reload,
	AutoMode
}

func play(sound):
	match sound:
		Gunshot:
			$Gunshot.play()
			await get_tree().create_timer(0.2).timeout
			play(CasingsDrop)
		Run: $Run.play()
		Beer: $Beer.play()
		Crowd: $Crowd.play()
		RaptorRoar: $RaptorRoar.play()
		RaptorHurt: $RaptorHurt.play()
		CasingsDrop: %CasingsTimer.start()
		Reload: $Reload.play()
		AutoMode: $AutoMode.play()

func _on_casings_timer_timeout():
	$CasingsDrop.play()
	%CasingsTimer.wait_time = maxf(%CasingsTimer.wait_time - randf_range(0.05, 0.2), 0.0)
	if %CasingsTimer.wait_time <= 0.1: 
		%CasingsTimer.stop()
		%CasingsTimer.wait_time = 0.5

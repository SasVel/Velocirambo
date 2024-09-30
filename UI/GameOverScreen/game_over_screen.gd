extends ColorRect

func _ready():
	GameData.game_won.connect(game_won)
	GameData.game_lost.connect(game_lost)

func game_won():
	%GameWonLabel.visible = true

func game_lost():
	%GameLostLabel.visible = true

func reset():
	%GameWonLabel.visible = false
	%GameLostLabel.visible = false

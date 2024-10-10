extends ColorRect

@onready var active : bool = false
func _ready():
	GameData.game_won.connect(game_won)
	GameData.game_lost.connect(game_lost)
	GameData.reset.connect(reset)

func _input(event):
	if !active: return
	if event.is_action_pressed("return_to_main_menu"):
		SceneManager.go_to_main_menu()

func game_won():
	active = true
	%GameWonLabel.visible = true
	self.visible = true

func game_lost():
	active = true
	%GameLostLabel.visible = true
	self.visible = true

func reset():
	active = false
	%GameWonLabel.visible = false
	%GameLostLabel.visible = false

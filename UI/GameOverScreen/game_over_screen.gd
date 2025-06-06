extends ColorRect

@onready var active : bool = false
@export var pauseScreen : PauseUI
func _ready():
	GameInfo.game_won.connect(game_won)
	GameInfo.game_lost.connect(game_lost)
	GameInfo.reset.connect(reset)

func _input(event):
	if !active: return
	if event.is_action_pressed("ui_accept"):
		reset()
		SceneManager.change_scene(SceneManager.Scenes.MainMenu)

func game_won():
	pauseScreen.disabled = true
	active = true
	%GameWonLabel.visible = true
	self.visible = true

func game_lost():
	pauseScreen.disabled = true
	active = true
	%GameLostLabel.visible = true
	self.visible = true
	get_tree().paused = true

func reset():
	pauseScreen.disabled = false
	active = false

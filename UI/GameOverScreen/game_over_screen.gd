extends ColorRect

@onready var mainMenuScn : PackedScene = ResourceLoader.load("res://UI/MainMenu/main_menu.tscn")

@onready var active : bool = false
func _ready():
	GameData.game_won.connect(game_won)
	GameData.game_lost.connect(game_lost)

func _input(event):
	if !active: return
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_packed(mainMenuScn)

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

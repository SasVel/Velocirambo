extends Node

@onready var floatingTextScn = preload("res://UI/FloatingText/floating_text.tscn")

@onready var main = get_tree().root.get_node("Main")
@onready var mainUI : MainUI = main.get_node("UI")
#@onready var player : Player

#func _ready():
#	SceneManager.scene_loaded.connect(reload_references)
#
#func reload_references():
#	player = SceneManager.stageInstance.get_node("/CompletePlayer/Player")

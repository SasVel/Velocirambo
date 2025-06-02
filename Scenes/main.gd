extends Node3D

@export var UI : CanvasLayer

func _ready():
	SceneManager.load_scene(SceneManager.Scenes.BootScreen)
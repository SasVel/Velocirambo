extends Node

@onready var mainMenuScn : PackedScene = ResourceLoader.load("res://UI/MainMenu/main_menu.tscn")

func go_to_main_menu():
	get_tree().change_scene_to_packed(mainMenuScn)

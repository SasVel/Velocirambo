extends Control

@onready var mainScn = preload("res://playScenes/main.tscn")

signal game_started

func _ready():
	%Settings.closed.connect(reset_main_menu)
	%Credits.closed.connect(reset_main_menu)
	%DarkenRect.visible = false

func close_main_menu():
	%DarkenRect.visible = true
	%MainMenuComponents.visible = false

func reset_main_menu(_component):
	%DarkenRect.visible = false
	%MainMenuComponents.visible = true

func _on_new_game_btn_pressed() -> void:
	get_tree().change_scene_to_packed(mainScn)
	game_started.emit()

func _on_settings_btn_pressed() -> void:
	close_main_menu()
	%Settings.visible = true

func _on_credits_btn_pressed() -> void:
	close_main_menu()
	%Credits.visible = true

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

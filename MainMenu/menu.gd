extends Control

@onready var mainScn = preload("res://playScenes/main.tscn")

func _ready():
	%Settings.closed.connect(reset_main_menu)

func reset_main_menu(_component):
	%MainMenuComponents.visible = true

func _on_new_game_btn_pressed() -> void:
	get_tree().change_scene_to_packed(mainScn)

func _on_settings_btn_pressed() -> void:
	%MainMenuComponents.visible = false
	%Settings.visible = true

func _on_credits_btn_pressed() -> void:
	pass # Replace with function body.

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

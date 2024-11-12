extends MenuComponent

@onready var mainScn = preload("res://playScenes/main.tscn")

signal game_started

func _ready():
	%Settings.closed.connect(reset_main_menu)
	%Credits.closed.connect(reset_main_menu)
	
	focusedComponent = %NewGameBtn
	reset_main_menu(self)
	
	if !GameInfo.data.askedUsingControllerMsg:
		GameInfo.data.usingController = await UI.show_yes_no_msg(self, "Are you using a controller? \n (Can always be changed in Settings)")
		GameInfo.data.askedUsingControllerMsg = true
		GameInfo.save_data()
		activate()

func _input(event):
	if GameInfo.data.usingController: Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func close_main_menu():
	%DarkenRect.visible = true
	%MainMenuComponents.visible = false

func reset_main_menu(_component):
	%DarkenRect.visible = false
	%Settings.visible = false
	%Credits.visible = false
	%MainMenuComponents.visible = true
	activate()

func _on_new_game_btn_pressed() -> void:
	get_tree().change_scene_to_packed(mainScn)
	game_started.emit()

func _on_settings_btn_pressed() -> void:
	close_main_menu()
	%Settings.activate()

func _on_credits_btn_pressed() -> void:
	close_main_menu()
	%Credits.activate()

func _on_quit_btn_pressed() -> void:
	if await UI.show_yes_no_msg(self):
		get_tree().quit()

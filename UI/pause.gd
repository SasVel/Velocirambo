extends Control

@onready var active : bool = false :
	set(val):
		get_tree().paused = val
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if val else Input.MOUSE_MODE_CAPTURED
		self.visible = val

func _input(event):
	if event.is_action_pressed("ESC"):
		active = !active

func _on_continue_btn_pressed():
	active = false

func _on_main_screen_btn_pressed():
	active = false
	SceneManager.go_to_main_menu()

func _on_quit_btn_pressed():
	get_tree().quit()

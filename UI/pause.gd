extends MenuComponent

##Pause screen. Disabled flag outrules active flag.

##Disables the pause screen. Outrules the active flag.
@onready var disabled : bool = false
@onready var active : bool = false :
	set(val):
		if disabled: return
		get_tree().paused = val
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if val: activate()
		self.visible = val

func _ready():
	focusedComponent = %ContinueBtn

func _input(event):
	if disabled: return
	if event.is_action_pressed("pause"):
		active = !active

func _on_continue_btn_pressed():
	active = false

func _on_main_screen_btn_pressed():
	active = false
	SceneManager.go_to_main_menu()

func _on_quit_btn_pressed():
	get_tree().quit()

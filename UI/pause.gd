extends MenuComponent
class_name PauseUI

##Pause screen. Disabled flag outrules active flag.

##Disables the pause screen. Outrules the active flag.
@onready var disabled : bool = false
@onready var active : bool = false :
	set(val):
		if disabled: return
		activate() if val else deactivate()
		get_tree().paused = val
		self.visible = val
		active = val

func _ready():
	focusedComponent = %ContinueBtn
	active = false

func _input(event):
	if disabled: return
	if event.is_action_pressed("pause"):
		active = !active

func activate():
	super()
	if GameInfo.data.usingController: Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func deactivate():
	if GameInfo.data.usingController: Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	else: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_continue_btn_pressed():
	active = false

func _on_main_screen_btn_pressed():
	if (!await UI.show_yes_no_msg(self, "CURRENT_PROGRESS_LABEL")): return
	active = false
	SceneManager.go_to_main_menu()

func _on_quit_btn_pressed():
	if (!await UI.show_yes_no_msg(self, "CURRENT_PROGRESS_LABEL")): return
	get_tree().quit()


func _on_settings_btn_pressed():
	close()
	%Settings.activate()
	%Settings.closed.connect(reset)

func close():
	%ButtonsContainer.visible = false

func reset(_component):
	%ButtonsContainer.visible = true
	activate()

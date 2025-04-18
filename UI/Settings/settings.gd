extends MenuComponent

const RESOLUTIONS : Dictionary = {
	"1152 x 648" : Vector2i(1152, 648),
	"1280 x 720" : Vector2i(1280, 720),
	"1920 x 1080" : Vector2i(1920, 1080),
}

func _ready():
	focusedComponent = %BackBtn

func activate():
	super()
	self.visible = true
	config_video_settings()
	config_crosshair_settings()
	config_vol_sliders()

func deactivate():
	GameInfo.save_data()
	self.visible = false
	closed.emit(self)

func config_controls_settings():
	%SensitivitySlider.value = GameInfo.data.cameraSensitivity
	%UsingControllerBtn.button_pressed = GameInfo.data.usingController
	%ControllerVibrationBtn.button_pressed = GameInfo.data.controllerVibration

func config_crosshair_settings():
	%ColorPickerButton.color = GameInfo.data.crossColor
	%OpacitySlider.value = GameInfo.data.crossOpacity
	%WidthSlider.value = GameInfo.data.crossWidth
	%LengthSlider.value = GameInfo.data.crossLength
	%InverseColorCheck.button_pressed = GameInfo.data.invertedColors

func config_video_settings():
	add_resolution_items()
	%WindowModeDrop.selected = GameInfo.data.windowMode
	%ResolutionDrop.selected = GameInfo.data.resolutionIdx

func config_vol_sliders():
	%MainVolSlider.value = GameInfo.data.mainVol
	%MusicVolSlider.value = GameInfo.data.musicVol
	%SfxVolSlider.value = GameInfo.data.sfxVol

func _on_main_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
	GameInfo.data.mainVol = value

func _on_music_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
	GameInfo.data.musicVol = value

func _on_sfx_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	GameInfo.data.sfxVol = value

func _on_back_btn_pressed():
	deactivate()

func _on_sensitivity_slider_value_changed(value):
	GameInfo.data.cameraSensitivity = value

func _on_color_picker_button_color_changed(color):
	GameInfo.data.crossColor = color

func _on_opacity_slider_value_changed(value):
	GameInfo.data.crossOpacity = value

func _on_width_slider_value_changed(value):
	GameInfo.data.crossWidth = value

func _on_length_slider_value_changed(value):
	GameInfo.data.crossLength = value

func _on_inverse_color_check_toggled(toggled_on):
	GameInfo.data.invertedColors = toggled_on

func _on_using_controller_btn_toggled(toggled_on):
	GameInfo.data.usingController = toggled_on

func _on_controller_vibration_btn_toggled(toggled_on):
	GameInfo.data.controllerVibration = toggled_on


func _on_window_mode_drop_item_selected(index : int):
	GameInfo.data.windowMode = index
	match index:
		0: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		2: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		3: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func add_resolution_items() -> void:
	for resolutionText in RESOLUTIONS:
		%ResolutionDrop.add_item(resolutionText)

func _on_resolution_drop_item_selected(index:int):
	GameInfo.data.resolutionIdx = index
	DisplayServer.window_set_size(RESOLUTIONS.values()[index])

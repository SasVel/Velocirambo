extends MenuComponent

var mainBusIndex : int
var musicBusIndex : int
var sfxBusIndex : int

func _ready():
	mainBusIndex = AudioServer.get_bus_index("Master")
	musicBusIndex = AudioServer.get_bus_index("Music")
	sfxBusIndex = AudioServer.get_bus_index("SFX")

func activate():
	self.visible = true
	config_video_settings()
	config_vol_sliders()

func deactivate():
	self.visible = false
	GameInfo.save_data()
	closed.emit(self)

func config_video_settings():
	%SensitivitySlider.value = GameInfo.data.mouseSensitivity
	
	%ColorPickerButton.color = GameInfo.data.crossColor
	%OpacitySlider.value = GameInfo.data.crossOpacity
	%WidthSlider.value = GameInfo.data.crossWidth
	%LengthSlider.value = GameInfo.data.crossLength
	%InverseColorCheck.button_pressed = GameInfo.data.invertedColors

func config_vol_sliders():
	%MainVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(mainBusIndex))
	%MusicVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(musicBusIndex))
	%SfxVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(sfxBusIndex))

func _on_main_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(mainBusIndex, linear_to_db(value))

func _on_music_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(musicBusIndex, linear_to_db(value))

func _on_sfx_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sfxBusIndex, linear_to_db(value))

func _on_back_btn_pressed():
	deactivate()

func _on_sensitivity_slider_value_changed(value):
	GameInfo.data.mouseSensitivity = value

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

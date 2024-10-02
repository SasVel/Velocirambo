extends MenuComponent

var mainBusIndex : int
var musicBusIndex : int
var sfxBusIndex : int

func _ready():
	mainBusIndex = AudioServer.get_bus_index("Master")
	musicBusIndex = AudioServer.get_bus_index("Music")
	sfxBusIndex = AudioServer.get_bus_index("SFX")
	
	config_vol_sliders()

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
	self.visible = false
	closed.emit(self)

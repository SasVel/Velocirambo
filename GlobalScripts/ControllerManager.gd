extends Node

@onready var vibrationEnabled : bool = GameInfo.data.controllerVibration

func start_vibration(weak_magnitude : float, strong_magnitude : float, duration : float):
	if !vibrationEnabled: return
	Input.start_joy_vibration(0, weak_magnitude, strong_magnitude, duration)

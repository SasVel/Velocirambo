extends Node
class_name Stats

signal health_changed(val)
signal no_health

@export var maxHealth : float = 100
@onready var health : float = maxHealth :
	set(val):
		health = clampf(val, 0, maxHealth)
		health_changed.emit(val)
		if health == 0: no_health.emit()
@export var damage : float = 10

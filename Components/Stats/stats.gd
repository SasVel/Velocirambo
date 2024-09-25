extends Node
class_name Stats

signal health_changed(val)

@export var maxHealth : float = 100
@onready var health : float = maxHealth :
	set(val):
		health_changed.emit(val)
		health = val
@export var damage : float = 10

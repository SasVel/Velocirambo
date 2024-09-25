extends Node

var position : Vector3

signal health_changed(val : float)

@export var maxHealth : float = 100
@export var health : float = maxHealth :
	set(val):
		health = clampf(val, 0, maxHealth)
		health_changed.emit(health)
@export var shootDmg : float = 10

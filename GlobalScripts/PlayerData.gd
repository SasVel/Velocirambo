extends Node

var position : Vector3

signal health_changed(val : float)

@export var maxHealth : float = 100
@export var health : float = maxHealth

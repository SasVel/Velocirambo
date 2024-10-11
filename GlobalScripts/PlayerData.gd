extends Node

var position : Vector3

signal health_changed(val : float)
signal bullets_changed(val : int)

func _ready():
	GameData.reset.connect(reset)

@export var maxHealth : float = 100
@export var health : float = maxHealth :
	set(val):
		health = clampf(val, 0, maxHealth)
		health_changed.emit(health)
		if health == 0: GameData.game_lost.emit()
@export var shootDmg : float = 10

@export var maxBullets : int = 7
var currBullets : int = maxBullets :
	set(val):
		currBullets = clamp(val, 0, maxBullets)
		bullets_changed.emit(currBullets)

func reset():
	health = maxHealth
	currBullets = maxBullets

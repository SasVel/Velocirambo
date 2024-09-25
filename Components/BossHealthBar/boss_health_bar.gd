extends Control
class_name BossHealthBar

@onready var bossName : String
@onready var stats : Stats

func init(_bossName : String, _statsComponent : Stats):
	bossName = _bossName
	stats = _statsComponent
	return self

func _ready() -> void:
	stats.health_changed.connect(update_health)

func _on_health_bar_ready() -> void:
	update_health(stats.health)
	update_max_health(stats.maxHealth)

func update_health(val):
	$HealthBar.value = val

func update_max_health(val):
	$HealthBar.max_value = val

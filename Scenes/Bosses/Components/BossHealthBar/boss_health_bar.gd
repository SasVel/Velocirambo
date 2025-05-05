extends Control
class_name BossHealthBar

@onready var bossName : String
@onready var stats : Stats
@onready var healthColor = Color("a00600")
@onready var fillStylebox = $HealthBar.get_theme_stylebox("fill")

func init(_bossName : String, _statsComponent : Stats):
	bossName = _bossName
	stats = _statsComponent
	return self

func _ready() -> void:
	stats.health_changed.connect(update_health)

func _on_label_ready():
	$Label.text = bossName

func _on_health_bar_ready() -> void:
	update_max_health(stats.maxHealth)
	update_health(stats.health)

func update_health(health):
	if health < $HealthBar.value:
		fillStylebox.bg_color = Color.WHITE
		await get_tree().create_timer(0.2).timeout
		fillStylebox.bg_color = healthColor
	$HealthBar.value = health

func update_max_health(val):
	$HealthBar.max_value = val

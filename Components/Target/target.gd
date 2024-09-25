extends Area3D
class_name Target

##Max target fade.
@export_range(0.1, 1) var maxFadeAlpha : float
@onready var sprite : Sprite3D = $Sprite
@export var statsComponent : Stats

func _ready() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(sprite, "modulate:a", maxFadeAlpha, 1)
	tween.tween_property(sprite, "modulate:a", 1, 1)

func hit(dmg : float):
	statsComponent.health -= dmg

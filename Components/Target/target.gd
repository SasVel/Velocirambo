extends Area3D

##Max target fade.
@export_range(0.1, 1) var maxFadeAlpha : float
@onready var sprite : Sprite3D = $Sprite

func _ready() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(sprite, "modulate:a", maxFadeAlpha, 1)
	tween.tween_property(sprite, "modulate:a", 1, 1)

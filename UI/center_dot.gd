extends CenterContainer
class_name CenterDot

@export var centerDot : Sprite2D

@onready var invertColorShader = preload("res://Shaders/InvertColor.gdshader")

func _ready():
	change_color(GameInfo.data.crossColor)
	change_opacity(GameInfo.data.crossOpacity)
	config_invert_shader()

func change_color(col : Color):
	centerDot.modulate = col

func change_opacity(val_normalised : float):
	centerDot.modulate.a = val_normalised

func config_invert_shader():
	if GameInfo.data.invertedColors: apply_invert_color_shader()
	else: remove_shader()

func apply_invert_color_shader():
	centerDot.material.shader = invertColorShader

func remove_shader():
	centerDot.material.shader = null

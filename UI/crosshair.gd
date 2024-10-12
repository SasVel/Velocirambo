extends CenterContainer

@onready var lineArr = [$Bottom, $Top, $Left, $Right]
@onready var invertColorShader = preload("res://Shaders/InvertColor.gdshader")

func _ready():
	change_color(GameData.crossColor)
	change_opacity(GameData.crossOpacity)
	change_length(GameData.crossLength)
	change_width(GameData.crossWidth)
	config_invert_shader()

func change_color(col : Color):
	for line in lineArr:
		line.default_color = col

#Changes the length of each crosshair beam. Ranges from 1 to 40.
func change_length(len : float):
	len = clampf(len, 1, 40)
	for line in lineArr:
		var points = line.points
		if points[1].x != 0:
			if points[1].x < 0: points[1].x = (len * -1) + points[0].x
			else: points[1].x = len + points[0].x
		else:
			if points[1].y < 0: points[1].y = (len * -1) + points[0].y
			else: points[1].y = len + points[0].y
		line.points = points

#Changes the width of each crosshair beam. Ranges from 1 to 10.
func change_width(val : float):
	val = clampf(val, 1, 10)
	for line in lineArr:
		line.width = val

#Changes crosshair opacity. Ranges from 0 to 1.
func change_opacity(val_normalised : float):
	for line in lineArr:
		line.default_color.a = val_normalised

func config_invert_shader():
	if GameData.invertedColors: apply_invert_color_shader()
	else: remove_shader()

func apply_invert_color_shader():
	for line in lineArr:
		line.material.shader = invertColorShader

func remove_shader():
	for line in lineArr:
		line.material.shader = null

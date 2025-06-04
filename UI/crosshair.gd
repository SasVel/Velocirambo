extends CenterDot

@onready var lineArr = [%Bottom, %Top, %Left, %Right]


func _ready():
	super()
	change_length(GameInfo.data.crossLength)
	change_width(GameInfo.data.crossWidth)

func _physics_process(_delta):
	change_center_offset(PlayerData.crossOffset)

func change_color(col : Color):
	super(col)
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
	super(val_normalised)
	for line in lineArr:
		line.default_color.a = val_normalised

func change_center_offset(offset):
	%Bottom.position.y = offset
	%Top.position.y = -offset
	%Left.position.x = -offset
	%Right.position.x = offset

func apply_invert_color_shader():
	super()
	for line in lineArr:
		line.material.shader = invertColorShader

func remove_shader():
	super()
	for line in lineArr:
		line.material.shader = null

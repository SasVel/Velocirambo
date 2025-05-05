extends ColorRect


@onready var isOn : bool = GameInfo.data.isBlur

func _ready():
	GameInfo.data.blurChanged.connect((func(val): isOn = val))
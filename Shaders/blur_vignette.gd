extends ColorRect
class_name BlurVignette

@onready var isActive : bool = GameInfo.data.isBlur

func _ready():
	GameInfo.data.blurChanged.connect(
		func(): isActive = GameInfo.data.isBlur
	)

func switch(isOn : bool):
	if !isActive: return
	self.visible = isOn
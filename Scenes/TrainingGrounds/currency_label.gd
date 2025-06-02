extends RichTextLabel

@onready var originalText

func _ready():
	originalText = self.text
	GameInfo.data.nuggiesChanged.connect(func(): update_value(GameInfo.data.nuggies))
	update_value(GameInfo.data.nuggies)

func update_value(val : int):
	self.text = originalText.replace("?", str(val))

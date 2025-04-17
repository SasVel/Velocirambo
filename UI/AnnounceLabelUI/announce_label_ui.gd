extends ComponentUI
class_name AnnounceUI

@export var textBG : TextureRect
@export var textLabel : RichTextLabel

var title : String
var desc : String

func _ready():
	visible = false
	textBG.pivot_offset = Vector2(textBG.size / 2)

func init(titleText : String, descriptionText : String):
	self.title = titleText
	self.desc = descriptionText
	return self


func activate():
	textLabel.text = textLabel.text.replace("Title", title)
	textLabel.text = textLabel.text.replace("Desc", desc)
	textBG.scale = Vector2.ZERO

	visible = true
	var tween = create_tween()
	#First scale up
	tween.tween_property(textBG, "scale", Vector2.ONE, 0.5).from(Vector2.ZERO)
	tween.tween_property(textBG, "scale", Vector2(1.3, 1.3), 3)

	#Scale and fade out
	tween.set_parallel()
	tween.tween_property(textBG, "scale", Vector2(2, 2), 1).set_delay(1)
	tween.tween_property(textBG, "modulate:a", 0, 1).from(1).set_delay(1)

	await tween.finished

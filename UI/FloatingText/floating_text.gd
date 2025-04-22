extends Label3D
class_name FloatingText

var offsetDir : Vector2
@export var distance : float = 55
@export var fadeInTime = 0.2
@export var pauseTime = 0.4
@export var fadeOutTime = 0.2

func _ready():
	visible = false

func init(_text : String):
	offsetDir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	self.text = _text
	visible = true
	await animate()
	queue_free()

func animate():
	var tween = create_tween()
	var tween1 = create_tween()
	tween1.parallel().tween_property(self, "offset", distance * offsetDir, 2)
	
	tween.tween_property(self, "scale", Vector3(1.4, 1.4, 1.4), fadeInTime).from(Vector3.ZERO)
	tween.parallel().tween_property(self, "modulate:a", 0.85, fadeInTime).from(0)

	tween.tween_property(self, "scale", Vector3(1.0, 1.0, 1.0), 0.3)
	tween.tween_property(self, "modulate:a", 0, fadeOutTime).set_delay(pauseTime)
	tween.parallel().tween_property(self, "outline_modulate:a", 0, fadeOutTime).set_delay(pauseTime)

	await tween.finished

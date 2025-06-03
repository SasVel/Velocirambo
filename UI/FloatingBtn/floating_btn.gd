extends Sprite3D
class_name FloatingBtn

@export var label : Label3D

@export var maxScale : Vector3 = Vector3(1.2, 1.2, 1.2)
@export var transTime = 1.6

func _ready():
	visible = false
	animate()

func init(ch : String):
	label.text = ch

func animate():
	var tween := create_tween().set_trans(Tween.TRANS_BACK).set_loops()
	tween.tween_property(self, "scale", maxScale, transTime / 2)
	tween.tween_property(self, "scale", Vector3.ONE, transTime / 2)
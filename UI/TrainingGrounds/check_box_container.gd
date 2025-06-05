extends TextureRect

@export var angleDeg = 30

func _ready():
	animate()

func animate():
	var tween := create_tween().set_trans(Tween.TRANS_CIRC).set_loops()
	tween.tween_property(self, "rotation_degrees", angleDeg, 1)
	tween.tween_property(self, "rotation_degrees", -angleDeg, 1)
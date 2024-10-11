extends Area3D
class_name Pickup

##A generic pickup class. To be inherited.

##Value amount from picking up the pickup.
@export var valueAmount : float = 15

func _ready():
	animate_rot_y()
	animate_move_y()

##To be overwritten
func picked_up():
	pass

func animate_rot_y():
	var tween = create_tween().set_loops()
	tween.tween_property(self, "rotation:y", TAU, 5).from(0)

func animate_move_y():
	var tween = create_tween().set_loops().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", 0.5, 1)
	tween.tween_property(self, "position:y", 0, 1)

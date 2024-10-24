extends Node
class_name ScaleTween

@export var object : Node3D
@export var scaleVector = Vector3.ZERO
@export var time : float

func activate():
	var tween = create_tween()
	tween.tween_property(object, "scale", scaleVector, time * 0.5)
	tween.tween_property(object, "scale", Vector3(1,1,1), time * 0.5)
	await tween.finished

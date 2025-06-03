extends Node
class_name ScaleTween

@export var object : Node3D
@export var scaleVector = Vector3.ZERO
@export var time : float

var originalScale : Vector3
var tween : Tween
var active : bool = false

func activate():
	if active: return

	originalScale = object.scale
	active = true
	tween = create_tween()
	tween.tween_property(object, "scale", originalScale * scaleVector, time * 0.5)
	tween.tween_property(object, "scale", originalScale, time * 0.5)
	await tween.finished
	active = false

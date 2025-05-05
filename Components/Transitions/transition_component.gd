extends Control

@export var speed = 2

func reveal():
	%RevealRect.visible = true
	%ConcealRect.visible = false

	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(%RevealRect.material, "shader_parameter/progress", 0, speed).from(1)
	await tween.finished

func conceal():
	%RevealRect.visible = false
	%ConcealRect.visible = true

	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(%ConcealRect.material, "shader_parameter/progress", 1, speed).from(0)
	await tween.finished

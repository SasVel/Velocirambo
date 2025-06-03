extends Area3D
class_name InteractComponent

## Component handling all interactions

## Is active on button press
@export var isBtnPress = true
@export var btnLabel : FloatingBtn

signal activated
signal deactivated

func _input(event):
	if !isBtnPress: return

	if event.is_action_pressed("Interact"):
		activated.emit()
		btnLabel.visible = false

func _on_body_entered(_body:Node3D):
	if !isBtnPress: activated.emit()
	else: btnLabel.visible = true

func _on_body_exited(_body:Node3D):
	btnLabel.visible = false
	deactivated.emit()

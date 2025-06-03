extends Area3D
class_name InteractComponent

## Component handling all interactions

## Is active on button press
@export var isBtnPress = true
@export var btnLabel : FloatingBtn

var playerRef

signal activated(player : Player)
signal deactivated(player : Player)


func _input(event):
	if !isBtnPress: return

	if event.is_action_pressed("Interact") && self.has_overlapping_bodies():
		activated.emit(playerRef)
		btnLabel.visible = false

func _on_body_entered(player : Player):
	playerRef = player
	if !isBtnPress: activated.emit(player)
	else: btnLabel.visible = true

func _on_body_exited(player : Player):
	btnLabel.visible = false
	deactivated.emit(player)
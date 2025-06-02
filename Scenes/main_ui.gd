extends CanvasLayer
class_name MainUI

@export var interactUI : Control
@export var battleUI : Control

func _ready():
	interactUI.visible = false
	battleUI.visible = false

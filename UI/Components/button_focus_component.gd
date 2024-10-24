extends Node
class_name ButtonFocusComponent

@onready var btn : Button = self.get_parent()

func _ready():
	btn.mouse_entered.connect(_on_mouse_entered)

func _on_mouse_entered():
	btn.grab_focus()

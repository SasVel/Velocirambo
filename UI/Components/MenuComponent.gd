extends Control
class_name MenuComponent

## Interface for menu components. That means every UI that gets opened and closed.

signal closed(component)

##Focuses component upon menu activation.
var focusedComponent : Control

##To be overwritten with super() on top.
func activate():
	set_focus()

##To be overwritten.
func deactivate():
	pass

func set_focus():
	focusedComponent.grab_focus()

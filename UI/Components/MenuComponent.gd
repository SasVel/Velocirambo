extends Control
class_name MenuComponent

## Interface for menu components. That means every UI that gets opened and closed.

signal closed(component)

##To be overwritten.
func activate():
	pass

##To be overwritten.
func deactivate():
	pass

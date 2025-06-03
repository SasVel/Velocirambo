extends Node3D

@export var objCamera : PhantomCamera3D
func _ready():
	UI.change_mode(UIHelper.Modes.Interact)
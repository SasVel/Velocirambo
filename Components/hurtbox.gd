extends Area3D
class_name Hurtbox

@export var statsComponent : Stats

func hit(dmg : float):
	statsComponent.health -= dmg

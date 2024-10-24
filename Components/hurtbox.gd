extends Area3D
class_name Hurtbox

@export var statsComponent : Stats

signal hurtbox_hit(dmg : float, hitVector : Vector3)

func hit(dmg : float, hitVector : Vector3 = Vector3.ZERO):
	statsComponent.health -= dmg
	hurtbox_hit.emit(dmg, hitVector)

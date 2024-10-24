extends Area3D
class_name Hitbox

##General hitbox script

@export var stats : Stats

##Multiplier for the damage value in the stats component
@export_range(1, 5) var dmgMultiplier = 1.5

func _on_area_entered(area):
	area.hit(stats.damage * dmgMultiplier)

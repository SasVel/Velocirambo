extends Hitbox
class_name ObjectHitbox

func _on_area_entered(area):
	pass

func activate():
	for area in self.get_overlapping_areas():
		area.hit(stats.damage * dmgMultiplier)

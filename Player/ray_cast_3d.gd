extends RayCast3D

func _on_player_shot_gun() -> void:
	if self.is_colliding():
		var target : Target = get_collider()
		target.hit(PlayerData.shootDmg)

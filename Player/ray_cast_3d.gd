extends RayCast3D

@onready var defaultTargetPos : Vector3 = self.target_position

func _on_player_shot_gun(isAiming : bool) -> void:
	if !isAiming:
		var offset = Rng.random_offset(20, -20, 5)
		target_position = Vector3(offset.x, offset.y, target_position.z)
	
	if self.is_colliding():
		var target : Target = get_collider()
		target.hit(PlayerData.shootDmg)
	reset_target_pos()

func reset_target_pos():
	self.target_position = defaultTargetPos

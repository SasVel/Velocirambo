extends RayCast3D

@onready var defaultTargetPos : Vector3 = self.target_position
@onready var gunHitParticles = preload("res://Player/Particles/gun_hit_particles.tscn")

func _on_player_shot_gun(isAiming : bool) -> void:
	if !isAiming:
		var offset = Rng.random_offset(20, -20, 5)
		target_position = Vector3(offset.x, offset.y, target_position.z)
	
	if !self.is_colliding(): return
	var collider = get_collider()
	Particles.spawn(gunHitParticles, self.get_collision_point())
	
	if collider is Target:
		var target : Target = get_collider()
		target.hit(PlayerData.shootDmg)
	reset_target_pos()

func reset_target_pos():
	self.target_position = defaultTargetPos

extends MeshInstance3D

@onready var bulletTrailScn = preload("res://Player/bullet_trail.tscn")
@onready var gunFireParticles = preload("res://Player/Particles/gun_fire_particles.tscn")

func _on_player_shot_gun(isAiming : bool) -> void:
	create_bullet_trail($GunMarker.position, 0.2, isAiming)
	Particles.spawn(gunFireParticles, $GunMarker.global_position)
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees:x", rotation_degrees.x + -4, 0.1)
	tween.parallel().tween_property(self, "scale:z", 0.8, 0.1)
	
	tween.tween_property(self, "rotation_degrees:x", 0, 0.2)
	tween.parallel().tween_property(self, "scale:z", 1, 0.2)

func create_bullet_trail(pos, time, isAiming : bool):
	var bulletTrail = bulletTrailScn.instantiate()
	add_child(bulletTrail)
	bulletTrail.position = pos
	var offset = Rng.random_offset(30, -30, 10)
	if !isAiming: bulletTrail.rotation_degrees = Vector3(offset.x, offset.y, 0)
	bulletTrail.visible = true
	
	await get_tree().create_timer(time).timeout
	remove_child(bulletTrail)

extends RigidBody3D

@onready var expParticlesScn = preload("res://Scenes/Bosses/Particles/big_explosion_particles.tscn")

@export var hitForce = 5

func _on_hurtbox_hurtbox_hit(_dmg, hitVector : Vector3):
	apply_impulse(hitVector.direction_to(self.global_position) * hitForce, hitVector)
	%ScaleTween.activate()

func _on_stats_no_health():
	Particles.spawn(expParticlesScn, self.global_position)
	%Hitbox.activate()
	queue_free()

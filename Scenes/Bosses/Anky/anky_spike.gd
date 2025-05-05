extends Obstacle
class_name AnkySpike

@export var speed : float = 15.0

@onready var explosionParticlesScn = preload("res://Scenes/Bosses/Particles/explosion_particles.tscn")
@onready var hitbox = $Hitbox
@onready var hitboxField = $Hitbox/HitboxField
@onready var model = $AnkySpike

func _ready():
	hitboxField.visible = false
	hitbox.monitoring = false

func _physics_process(_delta):
	if !freeze:
		model.look_at(angular_velocity)

func activate():
	apply_central_impulse(dir * speed)

func _on_body_entered(_body):
	freeze = true
	hitboxField.visible = true
	hitbox.monitoring = true

func die():
	Particles.spawn(explosionParticlesScn, global_position)
	queue_free()

func _on_boss_hitbox_area_entered(_area):
	die()

func _on_life_timer_timeout():
	die()

func _on_stats_no_health():
	die()

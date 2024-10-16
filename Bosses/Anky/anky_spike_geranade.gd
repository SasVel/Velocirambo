extends AnkySpike

@onready var spikeParticlesScn = preload("res://Bosses/Particles/spike_dissapear_particles.tscn")
var isGeranade : bool = false

func _ready():
	%AnkySpike.visible = true
	%Geranade.visible = false
	super()

func _physics_process(delta):
	pass

func _on_body_entered(body):
	if !isGeranade:
		%AnkySpike.queue_free()
		%Geranade.visible = true
		Particles.spawn(spikeParticlesScn, self.global_position)
		isGeranade = true
	hitboxField.visible = true
	hitbox.monitoring = true

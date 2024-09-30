extends GPUParticles3D

func _ready():
	emitting = true

func _on_finished():
	self.queue_free()

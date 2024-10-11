extends Node

## Spawns particles at at a given global position. Returns a reference to the created instance.
func spawn(particlesScn : PackedScene, position : Vector3, rotation : Vector3 = Vector3.ZERO) -> GPUParticles3D:
	var inst : GPUParticles3D = particlesScn.instantiate()
	get_tree().get_root().add_child(inst)
	inst.global_position = position
	if rotation != Vector3.ZERO:
		inst.global_rotation = rotation
	return inst

extends Node

## Spawns particles at at a given global position. Returns a reference to the created instance.
func spawn(particlesScn : PackedScene, position : Vector3) -> GPUParticles3D:
	var inst : GPUParticles3D = particlesScn.instantiate()
	get_tree().get_root().add_child(inst)
	inst.global_position = position
	return inst

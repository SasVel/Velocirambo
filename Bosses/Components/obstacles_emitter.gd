extends Node3D

@export var obstacleScn : PackedScene
@onready var emitTimer : Timer = $EmitTimer

##Spawns a set number of obstacles in random directions in a set delay
func spawn(num, delay):
	emitTimer.wait_time = delay
	emitTimer.start()
	for i in num:
		await emitTimer.timeout
		_spawn_obstacle()
	emitTimer.stop()

func _spawn_obstacle():
	var inst : Obstacle = obstacleScn.instantiate()
	inst.dir = Vector3(randf_range(-1.0, 1.0), 1, randf_range(-1.0, 1.0))
	get_tree().get_root().add_child(inst)
	inst.global_position = self.global_position
	inst.activate()

extends Node3D

@export var obstacleScenes : Array[PackedScene]
@onready var emitTimer : Timer = $EmitTimer

##Spawns a set number of obstacles in random directions in a set delay
func spawn_continious(num, delay, obstacleIdx = 0):
	emitTimer.wait_time = delay
	emitTimer.start()
	for i in num:
		await emitTimer.timeout
		_spawn_obstacle(obstacleIdx)
	emitTimer.stop()

func spawn(num, obstacleIdx = 0):
	for i in num:
		_spawn_obstacle(obstacleIdx)

func _spawn_obstacle(idx):
	var inst : Obstacle = obstacleScenes[idx].instantiate()
	inst.dir = Vector3(randf_range(-1.0, 1.0), 1, randf_range(-1.0, 1.0))
	get_tree().get_root().add_child(inst)
	inst.global_position = self.global_position
	inst.activate()

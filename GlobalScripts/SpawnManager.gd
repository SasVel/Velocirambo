extends Node

##Manager for spawning objects.

##Spawn size in meters.
@export var spawnSize : float = 30
@onready var healthPickupScn : PackedScene = preload("res://Components/Pickcups/health_pickup.tscn")
@onready var pickupsArr : Array[Pickup]

enum Bosses {
	Anky
}

var bossScnDict : Dictionary[Bosses, PackedScene] = {
	Bosses.Anky: preload("res://Scenes/Bosses/Anky/anky_boss.tscn")
}

var isSpawningPickups : bool = false :
	set(val):
		isSpawningPickups = val
		if val: %PickupsTimer.start()
		else: %PickupsTimer.stop()

func get_random_spawn_position() -> Vector3:
	return Vector3(randf_range(-spawnSize, spawnSize), 0, randf_range(-spawnSize, spawnSize))

func spawn_boss(type : Bosses, pos : Vector3) -> Node3D:
	return spawn(bossScnDict[type], pos)

func spawn(objScn : PackedScene, pos = get_random_spawn_position()) -> Node:
	var inst = objScn.instantiate()
	get_tree().get_root().add_child(inst)
	inst.global_position = pos
	if inst is Pickup: pickupsArr.push_back(inst)
	return inst

func _on_pickups_timer_timeout():
	%PickupsTimer.wait_time = randf_range(20.0, 40.0)
	spawn(healthPickupScn)
	%PickupsTimer.start()

func clear_pickups():
	for pickup in pickupsArr:
		pickup.queue_free()

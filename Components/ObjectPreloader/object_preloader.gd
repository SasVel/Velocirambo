extends Node3D
class_name ObjectPreloader

@export var objects: Array[PackedScene]
var loadedArr : Array[bool]

signal loaded

func load_objects():
	for obj in objects:
		var inst = obj.instantiate()
		self.add_child(inst)
		loadedArr.append(true)
		await get_tree().physics_frame
		inst.queue_free()
	loaded.emit()
	
func get_load_percentage() -> float:
	var percent = float(loadedArr.size()) / objects.size()
	return percent
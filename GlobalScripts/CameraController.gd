extends Node
class_name CameraController

## Controller of the phantom cameras, since using priority instead of active camera is kind of awkward.
## Put the player phantom camera as the first one.

@export var phCameras : Array[PhantomCamera3D]

var currCameraIdx = 0

func set_current_camera(idx : int):
	phCameras[currCameraIdx].priority = 0
	phCameras[idx].priority = 10
	currCameraIdx = idx
	await get_tree().create_timer(phCameras[idx].tween_resource.duration).timeout


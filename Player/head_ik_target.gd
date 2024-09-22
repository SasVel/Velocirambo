extends Marker3D

@export var camera : Camera3D
@onready var defaultTargetPos = self.position

func _physics_process(delta: float) -> void:
	print(camera.get_global_transform().basis.z.y)
	var cameraDir = camera.get_global_transform().basis.z
	self.position.y = defaultTargetPos.y * -(cameraDir.y * 10)

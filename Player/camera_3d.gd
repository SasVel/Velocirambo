extends Camera3D

##Lower the number = faster the speed. Too lazy to fix.
@export_range(0.0, 1.0) var zoom_speed : float = 0.4

func zoom_fov(FOV):
	var tween = create_tween()
	tween.tween_property(self, "fov", FOV, zoom_speed)

func reset_fov():
	var tween = create_tween()
	tween.tween_property(self, "fov", 75, zoom_speed)

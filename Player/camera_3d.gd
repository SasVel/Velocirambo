extends Camera3D
class_name PlayerCamera

##Class for the player camera. Contains zoom and shake controls.

#region Zoom
##Lower the number = faster the speed. Too lazy to fix.
@export_range(0.0, 1.0) var zoom_speed : float = 0.4

func zoom_fov(FOV):
	var tween = create_tween()
	tween.tween_property(self, "fov", FOV, zoom_speed)

func reset_fov():
	var tween = create_tween()
	tween.tween_property(self, "fov", 75, zoom_speed)

#endregion
#region Shake
@export_category("Camera Shake")
##Default camera shake strength, ranges from 0.1 to 1.
@export_range(0.1, 1) var shakeStr : float = 0.5
var currShakeStr : float = 0.0

##Defaut camera shake fade, how fast the shake reduces to 0.
##Because it's multiplied by delta, the number has to be a lot bigger than shake str.
##There is a better way of doing this probably.
@export_range(1, 10) var shakeFade : float = 0.5
var currShakeFade : float = 0.0

@onready var rng = RandomNumberGenerator.new()
var isShakeActive : bool = false

func apply_shake(strength : float = shakeStr, fade : float = shakeFade):
	currShakeStr = strength
	currShakeFade = fade
	isShakeActive = true

func _physics_process(delta):
	if isShakeActive:
		currShakeStr = lerpf(currShakeStr, 0, shakeFade * delta)
		var offset = random_offset()
		h_offset = offset.x
		v_offset = offset.y
		if currShakeStr <= 0: 
			isShakeActive = false

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-currShakeStr, currShakeStr), rng.randf_range(-currShakeStr, currShakeStr))
#endregion

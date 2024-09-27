extends Camera3D
class_name PlayerCamera

##Class for the player camera. Contains zoom and shake controls.

func _physics_process(delta):
	if isShakeActive:
		currShakeStr = lerpf(currShakeStr, 0, shakeFade * delta)
		var offset = Rng.random_offset(currShakeStr)
		h_offset = offset.x
		v_offset = offset.y
		if currShakeStr <= 0: 
			isShakeActive = false
	
	if isRotOffset:
		rotation_degrees = lerp(rotation_degrees, defaultRotDegrees, rotFadeDuration * delta)
		if is_equal_approx(rotation_degrees.x, defaultRotDegrees.x):
			isRotOffset = false

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
var isShakeActive : bool = false

func apply_shake(strength : float = shakeStr, fade : float = shakeFade):
	currShakeStr = strength
	currShakeFade = fade
	isShakeActive = true

@onready var defaultRotDegrees = self.rotation_degrees
var isRotOffset : bool = false : 
	set(val):
		if !val:
			rotFadeDuration = 0.5
			rotOffset = Vector2.ZERO
		isRotOffset = val
var rotOffset = Vector2.ZERO
var rotFadeDuration : float = 5

func apply_rot_offset(offset : Vector2, duration : float = rotFadeDuration):
	if isRotOffset:
		rotOffset += offset
		rotFadeDuration += duration
	else:
		rotOffset = offset
		rotFadeDuration = duration
		isRotOffset = true
	rotation_degrees = defaultRotDegrees + Vector3(rotOffset.x, rotOffset.y, 0)
#endregion

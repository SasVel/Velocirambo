extends Hurtbox
class_name Target

##A specialized hurtbox that shows a target

##Max target fade.
@export_range(0.1, 1) var maxFadeAlpha : float
@onready var sprite : Sprite3D = $Sprite
@export var targetIdx : int
@export var enabled : bool = false :
	set(val):
		self.monitorable = val
		self.monitoring = val
		enabled = val

func _ready() -> void:
	self.visible = false
	var tween = create_tween().set_loops()
	tween.tween_property(sprite, "modulate:a", maxFadeAlpha, 1)
	tween.tween_property(sprite, "modulate:a", 1, 1)

func hit(dmg : float, hitVector : Vector3 = Vector3.ZERO):
	if enabled: super(dmg, hitVector)

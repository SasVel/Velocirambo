extends Node
class_name ButtonAnimComponent

@export var time : float = 0.3
@export var size : Vector2 = Vector2(1.2, 1.2)
@export var pivotPos : PIVOTPOS = PIVOTPOS.Center
@export var transitionType : Tween.TransitionType
@export var activeWhenFocused : bool = true

@onready var btn : Button = self.get_parent()
@onready var tween : Tween

enum PIVOTPOS { Left, Center, Right }

func _ready():
	btn.pressed.connect(on_pressed)
	if !activeWhenFocused:
		btn.mouse_entered.connect(on_hovered)
		btn.mouse_exited.connect(reset_hover)
	else:
		btn.focus_entered.connect(on_hovered)
		btn.focus_exited.connect(reset_hover)
	
	await get_tree().physics_frame
	setup()

func setup():
	match pivotPos:
		PIVOTPOS.Left:
			btn.pivot_offset.y = btn.size.y / 2
		PIVOTPOS.Center:
			btn.pivot_offset = btn.size / 2
		PIVOTPOS.Right:
			btn.pivot_offset = Vector2(btn.size.x, btn.size.y / 2)

func on_pressed():
	pass

func on_hovered():
	add_tween("scale", size, time)

func reset_hover():
	add_tween("scale", Vector2(1.0,1.0), time)

func add_tween(propertyStr : String, value, timeVal):
	if tween: tween.kill()
	tween = create_tween().set_trans(transitionType)
	tween.tween_property(btn, propertyStr, value, timeVal)

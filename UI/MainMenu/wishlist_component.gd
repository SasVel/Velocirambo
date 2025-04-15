extends Button


@export var beerIcon : TextureRect

@export var rotDegrees : float = 12
@export var rotSpeed : float = 0.4
@export var rotPauseDelay : float = 0.15

func _ready():
	beerIcon.pivot_offset = Vector2(beerIcon.size.x / 2, beerIcon.size.y / 2)
	var tween = create_tween().set_loops()
	tween.tween_property(beerIcon, "rotation_degrees", rotDegrees, rotSpeed).set_delay(rotPauseDelay)
	tween.tween_property(beerIcon, "rotation_degrees", rotDegrees * -1, rotSpeed).set_delay(rotPauseDelay)


func _on_pressed():
	OS.shell_open("")

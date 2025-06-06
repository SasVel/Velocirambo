extends Button


@export var beerIcon : TextureRect
@export var linkStr : String

@export var rotDegrees : float = 12
@export var rotSpeed : float = 0.4
@export var rotPauseDelay : float = 0.15

func _ready():
	beerIcon.pivot_offset = Vector2(beerIcon.size.x / 2, beerIcon.size.y / 2)
	var tween = create_tween().set_loops()
	tween.tween_property(beerIcon, "rotation_degrees", rotDegrees, rotSpeed).set_delay(rotPauseDelay)
	tween.tween_property(beerIcon, "rotation_degrees", rotDegrees * -1, rotSpeed).set_delay(rotPauseDelay)


func _on_pressed():
	OS.shell_open(linkStr)
	if GameInfo.data.hasWishlistReward: return
	
	SteamStuff.unlock_ach(SteamStuff.Ach.WISHLIST_CLICK)
	GameInfo.data.hasWishlistReward = true
	GameInfo.data.nuggies += 5
	GameInfo.save_data()
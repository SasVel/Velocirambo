extends TextureRect

##Bullet size Y in pixels. Multiplying this value will display the right amount of ammo.
@onready var bulletSizeY : float = 85

func _ready():
	PlayerData.bullets_changed.connect(update_display)
	update_display(PlayerData.maxBullets)

func update_display(bulletNum : int):
	size.y = bulletSizeY * bulletNum

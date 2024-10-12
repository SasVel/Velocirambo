extends Panel

@onready var bulletRectScn = preload("res://UI/StatsDisplay/GunModeDisplay/bullet_rect.tscn")

func _ready():
	change_display(PlayerData.isGunAuto)
	PlayerData.auto_mode_changed.connect(change_display)

func change_display(isAuto : bool):
	clear_display()
	if isAuto:
		for i in 3: spawn_bullet_rect()
	else: spawn_bullet_rect()

func spawn_bullet_rect():
	var inst = bulletRectScn.instantiate()
	%BulletsContainer.add_child(inst)

func clear_display():
	for rect in $BulletsContainer.get_children():
		rect.queue_free()

extends ProgressBar

func _ready() -> void:
	await get_tree().physics_frame
	update_max_health(PlayerData.maxHealth)
	update_health(PlayerData.health)
	PlayerData.health_changed.connect(update_health)

func update_health(val):
	self.value = val

func update_max_health(val):
	self.max_value = val

extends Pickup
class_name HealthPickup

func _on_body_entered(body):
	picked_up(PlayerData.health)
	SFX.play(SFX.Beer)
	queue_free()

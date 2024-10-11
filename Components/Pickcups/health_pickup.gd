extends Pickup
class_name HealthPickup

func _on_body_entered(body):
	picked_up()
	SFX.play(SFX.Beer)
	queue_free()

func picked_up():
	PlayerData.health += valueAmount

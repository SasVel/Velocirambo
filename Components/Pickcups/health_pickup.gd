extends Pickup
class_name HealthPickup

@onready var beerPickupParticlesScn = preload("res://Components/Pickcups/beer_pickup_particles.tscn")

func _on_body_entered(body):
	picked_up()
	SFX.play(SFX.Beer)
	queue_free()

func picked_up():
	PlayerData.health += valueAmount
	Particles.spawn(beerPickupParticlesScn, self.global_position)

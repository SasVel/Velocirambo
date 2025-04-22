extends Pickup
class_name HealthPickup

@onready var beerPickupParticlesScn = preload("res://Components/Pickcups/beer_pickup_particles.tscn")

func _on_body_entered(body):
	SFX.play(SFX.Beer)
	await picked_up()
	SteamStuff.unlock_ach(SteamStuff.Ach.GRAB_A_BEER)
	queue_free()

func picked_up():
	PlayerData.health += valueAmount
	Particles.spawn(beerPickupParticlesScn, self.global_position)
	await %ScaleTween.activate()

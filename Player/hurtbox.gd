extends Area3D

signal got_hit(dmg)

func hit(dmg):
	PlayerData.health -= dmg
	got_hit.emit(dmg)
	SFX.play(SFX.RaptorHurt)

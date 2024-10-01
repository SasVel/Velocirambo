extends Area3D

func hit(dmg):
	PlayerData.health -= dmg
	SFX.play(SFX.RaptorHurt)

extends Node

@onready var rng = RandomNumberGenerator.new()

func random_offset(upperBound, lowerBound = -upperBound, minLowerOffset : float = 0) -> Vector2:
	return Vector2(maxf(rng.randf_range(lowerBound, upperBound), minLowerOffset), \
					maxf(rng.randf_range(lowerBound, upperBound), minLowerOffset))

extends Timer

@export_range(0.2, 1.0) var waitTimeRandomness : float = 0.5

func _ready():
	self.wait_time = randf_range(self.wait_time * (1.0 - waitTimeRandomness), self.wait_time * (1.0 + waitTimeRandomness))

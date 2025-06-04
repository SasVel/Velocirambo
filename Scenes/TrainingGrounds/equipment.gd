extends InteractObject

func _on_interact_component_activated(player:Player):
	super(player)
	player.isControlled = false
	player.tween_move(self.position)
	player.tween_rotate_y(deg_to_rad(0))

func _on_interact_component_deactivated(player:Player):
	super(player)
	player.isControlled = true

extends Node3D

func _on_equip_interact_component_activated(player:Player) -> void:
	player.isControlled = false
	player.tween_move(self.position)
	player.tween_rotate_y(deg_to_rad(0))


func _on_equip_interact_component_deactivated(player:Player) -> void:
	player.isControlled = true

extends MeshInstance3D

func _on_player_shot_gun() -> void:
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees:x", rotation_degrees.x + -4, 0.1)
	tween.parallel().tween_property(self, "scale:z", 0.8, 0.1)
	
	tween.tween_property(self, "rotation_degrees:x", 0, 0.2)
	tween.parallel().tween_property(self, "scale:z", 1, 0.2)

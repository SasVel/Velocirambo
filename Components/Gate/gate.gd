extends MeshInstance3D

@export var destination : SceneManager.Scenes

func _on_area_3d_body_entered(_body:Node3D):
	SceneManager.load_scene(destination)

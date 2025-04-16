# Create a Scene with a Node
# Add this script to it
# Add the Scene to the Autoloads
# Fulfill the material Array with all the Materials that are causing freeze
# It also works with Materials from ParticlesSystems

# preload_materials.gd
extends Node

# Load the array through Inspector
@export var materials: Array[Material]

signal loaded

func _ready():
	await _load_materials()
	loaded.emit()
	
func _load_materials():
	var sprites = []
	for material in materials:
		var sprite = Sprite2D.new()
		sprite.texture = PlaceholderTexture2D.new()
		sprite.material = material
		add_child(sprite)
		sprites.append(sprite)
	
        # Remove the sprites after being rendered
	await get_tree().create_timer(0.2).timeout
	for sprite in sprites:
		sprite.queue_free()
    
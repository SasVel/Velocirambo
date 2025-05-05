extends Node3D

@export var nuggieRect : TextureRect
@export var beerRect : TextureRect
@export var objPreloader : ObjectPreloader
@export var camera : Camera3D
@export var loadSlider : Slider

@onready var mainScn = preload("res://Scenes/main.tscn")

@export var beerRotDeg : float = 12
@export var beerRotSpeed : float = 0.4
@export var beerRotPause : float = 0.15

func _ready():
	camera.current = true
	objPreloader.loaded.connect(start_game)

	beer_anim()

func _process(_delta):
	loadSlider.value = objPreloader.get_load_percentage()

func start_game():
	await get_tree().create_timer(1).timeout
	SceneManager.load_scene(SceneManager.Scenes.Arena)

func beer_anim():
	beerRect.pivot_offset = Vector2(beerRect.size.x / 2, beerRect.size.y / 2)
	var tween = create_tween().set_loops()
	tween.tween_property(beerRect, "rotation_degrees", beerRotDeg, beerRotSpeed).set_delay(beerRotPause)
	tween.tween_property(beerRect, "rotation_degrees", beerRotDeg * -1, beerRotSpeed).set_delay(beerRotPause)

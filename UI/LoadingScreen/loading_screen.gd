extends Node3D

@export var nuggieRect : TextureRect
@export var beerRect : TextureRect
@export var objPreloader : ObjectPreloader
@export var camera : Camera3D
@export var loadSlider : Slider

@onready var mainScn = preload("res://playScenes/main.tscn")

func _ready():
	camera.current = true
	objPreloader.loaded.connect(start_game)

func _process(_delta):
	loadSlider.value = objPreloader.get_load_percentage()

func start_game():
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_packed(mainScn)

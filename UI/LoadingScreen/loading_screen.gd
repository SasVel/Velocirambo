extends Node3D
class_name LoadingScreen

@export var nuggieRect : TextureRect
@export var beerRect : TextureRect
@export var objPreloader : ObjectPreloader
@export var camera : Camera3D
@export var loadSlider : Slider

@onready var mainScn = preload("res://Scenes/main.tscn")
@onready var transitionComponent : TransitionComponent = %TransitionComponent

@export var beerRotDeg : float = 12
@export var beerRotSpeed : float = 0.4
@export var beerRotPause : float = 0.15

var isPreload = false

func _ready():
	camera.current = true

func activate(showLoadingBar = false, preloadObjects = false):
	isPreload = preloadObjects
	if isPreload: objPreloader.load_objects()

	transitionComponent.visible = !showLoadingBar

func deactivate():
	transitionComponent.visible = true
	self.visible = false

func set_loading_percent(loadPercentage : float):
	loadSlider.value = loadPercentage * 100

func beer_anim():
	beerRect.pivot_offset = Vector2(beerRect.size.x / 2, beerRect.size.y / 2)
	var tween = create_tween().set_loops()
	tween.tween_property(beerRect, "rotation_degrees", beerRotDeg, beerRotSpeed).set_delay(beerRotPause)
	tween.tween_property(beerRect, "rotation_degrees", beerRotDeg * -1, beerRotSpeed).set_delay(beerRotPause)

extends Control

@export var mainMenuScene : PackedScene
@export var logoSprites : AnimatedSprite2D

func _ready():
	logoSprites.modulate.a = 0
	logoSprites.frame = 0
	await get_tree().create_timer(0.5).timeout
	var tween = create_tween()
	tween.tween_property(logoSprites, "modulate:a", 1, 0.5).from(0)
	await tween.finished
	logoSprites.play("default")

func _on_logo_sprites_animation_finished():
	await get_tree().create_timer(0.8).timeout
	var tween = create_tween()
	tween.tween_property(logoSprites, "modulate:a", 0, 1.5)
	await tween.finished
	SceneManager.load_scene(SceneManager.Scenes.MainMenu)
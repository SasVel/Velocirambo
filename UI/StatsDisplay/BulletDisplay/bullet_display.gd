extends VBoxContainer

@onready var bulletRectScn = preload("res://UI/StatsDisplay/BulletDisplay/bullet_rect.tscn")

func _ready():
	change_display(PlayerData.maxBullets)
	PlayerData.bullets_changed.connect(change_display)

func change_display(bulletsNum):
	if bulletsNum == 0:
		remove_all_bullets()
		return
	
	var currBulletsNum : int = self.get_children().size()
	if currBulletsNum >= bulletsNum:
		for i in currBulletsNum - bulletsNum:
			await remove_bullet_rect()
		return
	
	for i in bulletsNum:
		spawn_bullet_rect()

func spawn_bullet_rect():
	var inst = bulletRectScn.instantiate()
	self.add_child(inst)

func remove_bullet_rect(rect = null):
	if rect == null: rect = self.get_child(self.get_children().size() - 1)
	await tween_bullet_rect(rect)
	if rect != null: rect.queue_free()

func remove_all_bullets():
	for rect in self.get_children():
		await remove_bullet_rect(rect)
		rect.queue_free()

var rectTween : Tween
func tween_bullet_rect(rect):
	if rectTween != null:
		rectTween.finished.emit()
		rectTween.kill()
	
	rectTween = create_tween()
	rectTween.tween_property(rect, "scale:x", 1.2, 0.05)
	rectTween.tween_property(rect, "scale:x", 1.0, 0.05)
	await rectTween.finished

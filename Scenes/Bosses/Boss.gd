extends CharacterBody3D
class_name Boss

@export var bossName : String
@export var speed : float = 5

@export var bossDefeatAch : SteamStuff.Ach = SteamStuff.Ach.NONE

@onready var bossHealthBarScn = preload("res://Scenes/Bosses/Components/BossHealthBar/boss_health_bar.tscn")


enum States {
	IDLE,
	WALK,
	ATTACK,
	DEAD
}

var state : States = States.IDLE : set = set_state
		
func set_state(val):
	state = val

func _ready() -> void:
	self.look_at(PlayerData.position, Vector3.UP, true)
	init_health_bar()

func _physics_process(delta: float) -> void:
	if state == States.DEAD: return
	match state:
		States.IDLE:
			idle_state(delta)
		States.WALK:
			walk_state(delta)
		States.ATTACK:
			attack_state()
	move_and_slide()

func idle_state(delta):
	velocity = velocity.move_toward(Vector3.ZERO, delta * 4)

func walk_state(_delta):
	velocity = global_position.direction_to(Vector3(PlayerData.position.x, global_position.y, PlayerData.position.z)) * speed
	var targetTransform = self.global_transform.looking_at(PlayerData.position, Vector3.UP, true)
	global_transform.basis = lerp(global_transform.basis.orthonormalized(), targetTransform.basis.orthonormalized(), 0.01)

func attack_state():
	pass

func init_health_bar():
	var healthBar : BossHealthBar = bossHealthBarScn.instantiate().init(bossName, $Stats)
	Ref.mainUI.add_child(healthBar)

##Moves towards a direction
func move_dir_tween(dir : Vector3, moveSpeed : float, time : float):
	var moveTween = create_tween()
	moveTween.tween_property(self, "velocity", dir * moveSpeed, time * 0.2)
	moveTween.tween_property(self, "velocity", Vector3.ZERO, time * 0.2).set_delay(time * 0.6)
	await moveTween.finished
	velocity = Vector3.ZERO

##Moves to a global position
func move_pos_tween(pos : Vector3, time : float):
	var moveToTween = create_tween()
	moveToTween.tween_property(self, "global_position", pos, time)
	await moveToTween.finished
	velocity = Vector3.ZERO

func _on_stats_no_health():
	state = States.DEAD
	SteamStuff.unlock_ach(bossDefeatAch)
	%DeathPlayer.play()
	%Targets.enabled = false
	GameInfo.game_won.emit()
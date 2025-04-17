extends CharacterBody3D

@export var bossName : String = "Anky"
@export var speed : float = 5
@onready var bossStage : int = 1 :
	set(val):
		bossStage = val
		boss_stage_changed.emit(val)
@export_range(0.1, 1.0) var animationTransTime : float = 0.2

@onready var bossHealthBarScn = preload("res://Bosses/Components/BossHealthBar/boss_health_bar.tscn")
@onready var animTree : AnimationTree = $AnimationTree
@onready var attackArea : Area3D = $AttackArea
@onready var stompParticlesScn = preload("res://Bosses/Particles/stomp_particles.tscn")
@onready var slamParticlesScn = preload("res://Bosses/Particles/slam_particles.tscn")

@onready var stateTransDefaultTime = $StateTransTimer.wait_time
@onready var atkCoolDefaultTime = $AttackCooldownTimer.wait_time

@onready var obstaclesEmitter = %ObstaclesEmitter

signal boss_stage_changed(stageIdx)

enum States {
	IDLE,
	WALK,
	ATTACK,
	DEAD
}
var state : States = States.IDLE :
	set(val):
		if val != States.ATTACK: animTransition(val)
		state = val

enum AttackStates {
	ROLL,
	TAIL,
	THROW
}
var attackState : AttackStates = AttackStates.ROLL

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
	run_state_trans_timer()

func walk_state(_delta):
	velocity = global_position.direction_to(Vector3(PlayerData.position.x, global_position.y, PlayerData.position.z)) * speed
	var targetTransform = self.global_transform.looking_at(PlayerData.position, Vector3.UP, true)
	global_transform.basis = lerp(global_transform.basis.orthonormalized(), targetTransform.basis.orthonormalized(), 0.01)
	run_state_trans_timer()

func run_state_trans_timer():
	if $StateTransTimer.is_stopped():
		$StateTransTimer.start()

var inAttack : bool = false
var canAttack : bool = true
func attack_state():
	if inAttack || !canAttack: return
	else: inAttack = true
	%Targets.enabled = false
	
	match attackState:
		AttackStates.ROLL:
			for i in bossStage:
				await _roll_attack()
		AttackStates.TAIL:
			await _tail_attack()
		AttackStates.THROW:
			for i in bossStage:
				await _throw_attack()
	
	attackState += 1
	if attackState > AttackStates.keys().size() - 1: 
		attackState = 0
		$AttackCooldownTimer.start()
		canAttack = false
	
	inAttack = false
	state = States.IDLE
	%Targets.enabled = true

func _roll_attack():
	%RollAttackPlayer.play()
	%RollParticles.emitting = true
	animTransition()
	self.look_at(PlayerData.position, Vector3.UP, true)
	obstaclesEmitter.spawn_continious(5, 0.3, bossStage - 1)
	await move_dir_tween(global_position.direction_to(Vector3(PlayerData.position.x, global_position.y, PlayerData.position.z)), speed * 3, 2.5)
	%RollParticles.emitting = false

func _tail_attack():
	%TailAttackPlayer.play()
	animTransition()
	await move_dir_tween(global_position.direction_to(Vector3(PlayerData.position.x, global_position.y, PlayerData.position.z)), speed * 0.3, 1.25)

var isThrowAttackDown : bool = false
func _throw_attack():
	self.look_at(PlayerData.position, Vector3.UP, true)
	
	#Jumps in the air
	%ThrowAtkStartPlayer.play()
	isThrowAttackDown = false
	animTransition()
	await move_dir_tween(Vector3.UP, speed * 3, 0.5)
	
	#Moves towards player
	await move_pos_tween(Vector3(PlayerData.position.x, global_position.y, PlayerData.position.z), 1)
	
	#Goes down
	%ThrowAtkEndPlayer.play()
	isThrowAttackDown = true
	animTransition()
	await move_pos_tween(Vector3(self.global_position.x, 0, self.global_position.z), 0.5)
	Particles.spawn(slamParticlesScn, self.global_position)
	obstaclesEmitter.spawn(4, bossStage - 1)
	await get_tree().create_timer(0.4).timeout
	

func _on_attack_cooldown_timer_timeout():
	canAttack = true
	run_state_trans_timer()

func _on_state_trans_timer_timeout():
	if state == States.DEAD: return
	if attackArea.has_overlapping_bodies() && canAttack:
		state = States.ATTACK
	else: state = States.WALK

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

##Designed to run when a new state is assigned, not every loop. 
func animTransition(animState : States = state):
	match animState:
		States.IDLE:
			animTree.set("parameters/states_trans/transition_request", "idle_state")
		States.WALK:
			animTree.set("parameters/states_trans/transition_request", "walk_state")
		States.ATTACK:
			match attackState:
				AttackStates.ROLL:
					animTree.set("parameters/states_trans/transition_request", "idle_state")
					animTree.set("parameters/roll_tail_blend/blend_amount", 0.0)
					animTree.set("parameters/attack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
				AttackStates.TAIL:
					animTree.set("parameters/states_trans/transition_request", "idle_state")
					
					if position.signed_angle_to(PlayerData.position, Vector3.UP) < 0:
						animTree.set("parameters/tail_attack_left_right/blend_amount",  1)
					else: animTree.set("parameters/tail_attack_left_right/blend_amount",  0)
					
					animTree.set("parameters/roll_tail_blend/blend_amount", 1.0)
					animTree.set("parameters/attack/request",  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
				AttackStates.THROW:
					animTree.set("parameters/throw_up_down/blend_amount", isThrowAttackDown)
					animTree.set("parameters/states_trans/transition_request", "throw_attack_state")
		States.DEAD:
			animTree.set("parameters/states_trans/transition_request", "death_state")

func init_health_bar():
	var healthBar : BossHealthBar = bossHealthBarScn.instantiate().init(bossName, $Stats)
	get_tree().get_root().get_node("/root/Main/UI").add_child(healthBar)

func _on_stats_no_health():
	state = States.DEAD
	SteamStuff.unlock(SteamStuff.Ach.ANKY_BOSS_DEFEAT)
	%DeathPlayer.play()
	%Targets.enabled = false
	GameInfo.game_won.emit()

##Spawns stomp particles at the global position of the StompGroundMarker
func spawn_stomp_particles():
	Particles.spawn(stompParticlesScn, %StompGroundMarker.global_position)
	%StompPlayer.play()

func _on_stats_health_changed(health):
	if health <= 0: return
	if randf_range(0, 1) >= 0.5: %HitPlayer.play()
	var reductionPercentage = maxf(health / $Stats.maxHealth, 0.25)
	$StateTransTimer.wait_time = stateTransDefaultTime * reductionPercentage
	$AttackCooldownTimer.wait_time = atkCoolDefaultTime * reductionPercentage
	check_second_stage(health)

func check_second_stage(health):
	if health <= $Stats.maxHealth / 2: 
		bossStage = 2

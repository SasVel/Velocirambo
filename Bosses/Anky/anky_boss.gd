extends CharacterBody3D

@export var speed : float = 3
@export_range(0.1, 1.0) var animationTransTime : float = 0.2
@onready var animTree : AnimationTree = $AnimationTree
@onready var attackArea : Area3D = $AttackArea

enum States {
	IDLE,
	WALK,
	ATTACK,
	DEAD
}
var state : States = States.IDLE :
	set(val):
		animTransition(val)
		state = val

enum AttackStates {
	ROLL,
	TAIL,
	THROW
}
var attackState : AttackStates = AttackStates.ROLL

func _ready() -> void:
	self.look_at(PlayerData.position, Vector3.UP, true)

func _physics_process(delta: float) -> void:
	match state:
		States.IDLE:
			idle_state(delta)
		States.WALK:
			walk_state(delta)
		States.ATTACK:
			attack_state()
		States.DEAD:
			dead_state()
	move_and_slide()

func idle_state(delta):
	velocity = velocity.move_toward(Vector3.ZERO, delta * 4)
	run_idle_walk_trans()

func walk_state(delta):
	velocity = self.position.direction_to(PlayerData.position) * speed
	var targetTransform = self.global_transform.looking_at(PlayerData.position, Vector3.UP, true)
	global_transform.basis = lerp(global_transform.basis.orthonormalized(), targetTransform.basis.orthonormalized(), 0.01)
	run_idle_walk_trans()

func run_idle_walk_trans():
	if $IdleWalkTransition.is_stopped(): $IdleWalkTransition.start()

func attack_state():
	run_idle_walk_trans()

func dead_state():
	pass

var animTransTween : Tween
##Designed to run when a new state is assigned, not every loop. 
##The tween interpolates between the different animations.
func animTransition(animState : States = state):
	if animTransTween != null: animTransTween.kill()
	animTransTween = create_tween()
	match animState:
		States.IDLE:
			animTransTween.tween_property(animTree, "parameters/idle_walk/blend_amount", 0.0, animationTransTime)
		States.WALK:
			animTransTween.tween_property(animTree, "parameters/idle_walk/blend_amount", 1.0, animationTransTime)
		States.ATTACK:
			match attackState:
				AttackStates.ROLL:
					animTransTween.tween_property(animTree, "parameters/roll_tail_throw_blend/blend_amount", -1.0, animationTransTime)
					animTree.set("parameters/attack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
				AttackStates.TAIL:
					animTransTween.tween_property(animTree, "parameters/roll_tail_throw_blend/blend_amount", 0.0, animationTransTime)
					animTree.set("parameters/attack/request",  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
				AttackStates.THROW:
					animTransTween.tween_property(animTree, "parameters/roll_tail_throw_blend/blend_amount", 1.0, animationTransTime)
					animTree.set("parameters/attack/request",  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		States.DEAD:
			animTransTween.tween_property(animTree, "parameters/live_dead/blend_amount", 1.0, animationTransTime)

func _on_idle_walk_transition_timeout() -> void:
	if state == States.IDLE:
		if attackArea.has_overlapping_bodies(): state = States.ATTACK
		else: state = States.WALK
	else: state = States.IDLE 

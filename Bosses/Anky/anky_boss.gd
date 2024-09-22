extends CharacterBody3D

@export var speed : float = 10

enum States {
	IDLE,
	WALK,
	ATTACK,
	DEAD
}
var state : States = States.WALK

enum AttackStates {
	ROLL,
	TAIL,
	THROW
}
var attackState : AttackStates

func _physics_process(delta: float) -> void:
	match state:
		States.IDLE:
			idle_state()
		States.WALK:
			walk_state(delta)
		States.ATTACK:
			attack_state()
		States.DEAD:
			dead_state()
	move_and_slide()

func idle_state():
	pass

func walk_state(delta):
	#velocity = self.position.direction_to(PlayerData.position) * speed
	rotation.y = lerp_angle(rotation.y, position.signed_angle_to(PlayerData.position, Vector3(0, 0, -1)), speed * delta)

func attack_state():
	pass

func dead_state():
	pass

extends CharacterBody3D

@export var walkingSpeed : float = 2.5
@export var runningSpeed : float = 5.0
##Multiplies the value in runningSpeed to get the sprinting speed.
@export var sprintMultiplier : float = 1.7
##how fast the body tries to catch up to the camera
@export var turnSpeed : float = 10.0
##TODO Currently not being used
@export var turningDeadZoneDegrees : float = 15.0

##The default value is very low for now, because my Mouse has way too much DPI.
@export var mouseSensitivity : float = 1.7
@export var zoomedInSensModifier : float = 0.5

##how far down can the camera look/how high can it go. This number should be negative.
@export var upperCameraLimitDegrees : float = -45.0
##how far up can the camera look/how low can it go. This number should be positive.
@export var lowerCameraLimitDegrees : float = 40.0

@export var cameraTarget : Marker3D
@export var horizontalRotPivot : Node3D
@export var skeleton : Skeleton3D
@onready var skelHeadIdx = skeleton.find_bone("Head")
@onready var animTree = $AnimationTree

signal shot_gun

# Controls the aiming state. Figured it should be seperate from the rest of the states, so they can overlap
var IS_AIMING : bool = false : set = set_aiming_state
enum PLAYER_STATE {IDLE, RUNNING, WALKING, SPRINTING, RAGDOLL}
var currentState : PLAYER_STATE = PLAYER_STATE.IDLE :
	set(newState):
		if currentState == newState: return
		if currentState != lastState: lastState = currentState
		currentState = newState
var lastState : PLAYER_STATE = PLAYER_STATE.IDLE

var mouseVelocity = Vector2.ZERO #Don't confuse with sensitivity

func _input(event):
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	if event is InputEventMouseMotion:
		mouseVelocity = event.screen_relative
	
	handleStateTransitions(event)
	
	if(currentState == PLAYER_STATE.IDLE || currentState == PLAYER_STATE.RUNNING || currentState == PLAYER_STATE.WALKING):
		if event.is_action_pressed("Leftclick"):
			shoot()
	if event.is_action_pressed("Aim"): IS_AIMING = true
	elif event.is_action_released("Aim"): IS_AIMING = false

func handleStateTransitions(event):
	if Input.get_vector("Backwards", "Forwards", "Leftways", "Rightways") != Vector2.ZERO:
		if Input.is_action_pressed("Aim"):
			currentState = PLAYER_STATE.WALKING
			return
		if Input.is_action_pressed("sprint"): currentState = PLAYER_STATE.SPRINTING
		elif event.is_action_released("sprint"): currentState = lastState
		else: currentState = PLAYER_STATE.RUNNING
	else: 
		currentState = PLAYER_STATE.IDLE

func _physics_process(delta):
	match currentState:
		PLAYER_STATE.IDLE:
			idleState(delta)
		PLAYER_STATE.RUNNING:
			runningState(delta)
		PLAYER_STATE.WALKING:
			walkingState(delta)
		PLAYER_STATE.SPRINTING:
			sprintingState(delta)
		PLAYER_STATE.RAGDOLL:
			ragdollState(delta)
	animTransition()
	move_and_slide()
	camera_move(delta)

func idleState(delta):
	gravity(delta)
	turn_body_to_camera(delta)
	player_stop(runningSpeed)

func runningState(delta):
	gravity(delta)
	turn_body_to_camera(delta)
	player_move(delta, runningSpeed)

func walkingState(delta):
	gravity(delta)
	turn_body_to_camera(delta)
	player_move(delta, walkingSpeed)

func sprintingState(delta):
	gravity(delta)
	turn_body_to_camera(delta)
	player_move(delta, runningSpeed * sprintMultiplier)

func set_aiming_state(val):
	if val:
		get_viewport().get_camera_3d().zoom_fov(60)
	else: 
		skeleton.clear_bones_global_pose_override()
		get_viewport().get_camera_3d().reset_fov()
	IS_AIMING = val

func ragdollState(delta):
	pass

func animTransition(state : PLAYER_STATE = currentState):
	match state:
		PLAYER_STATE.IDLE:
			animTree.set("parameters/idle_move/blend_amount", lerpf(animTree["parameters/idle_move/blend_amount"], 0.0, 0.1))
		PLAYER_STATE.WALKING:
			animTree.set("parameters/aim_transition/transition_request", "aiming")
			animTree.set("parameters/idle_move/blend_amount", lerpf(animTree["parameters/idle_move/blend_amount"], 1.0, 0.1))
		PLAYER_STATE.RUNNING:
			animTree.set("parameters/aim_transition/transition_request", "not_aiming")
			animTree.set("parameters/RunTime/scale", lerpf(animTree["parameters/RunTime/scale"], 1.0, 0.2))
			animTree.set("parameters/idle_move/blend_amount", lerpf(animTree["parameters/idle_move/blend_amount"], 1.0, 0.1))
		PLAYER_STATE.SPRINTING:
			animTree.set("parameters/aim_transition/transition_request", "not_aiming")
			animTree.set("parameters/RunTime/scale", lerpf(animTree["parameters/RunTime/scale"], sprintMultiplier, 0.2))
			animTree.set("parameters/idle_move/blend_amount", lerpf(animTree["parameters/idle_move/blend_amount"], 1.0, 0.1))

#TODO
func shoot():
	print("Shot!")
	shot_gun.emit()
	pass

# Add the gravity. Hasn't been changed since script creation
func gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

# Get the input direction and handle the movement.
func player_move(_delta, speed):
	#Controls got inverted for some reason. Couldn't figure out why so, uh, temporary fix.
	var input_dir : Vector2 = Input.get_vector("Leftways", "Rightways", "Forwards", "Backwards") * -1
	var direction = (horizontalRotPivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

# Handles decelerration.
func player_stop(speed):
	velocity = velocity.move_toward(Vector3.ZERO, speed)

func camera_move(delta):
	cameraTarget.position = position
	camera_turn(delta)

#checks for the Limits and then turns the camera
func camera_turn(delta):
	if(Input.mouse_mode != Input.MOUSE_MODE_CAPTURED):
		return
	
	var mouseModifier = mouseSensitivity * delta
	if(Input.is_action_pressed("Aim")): mouseModifier *= zoomedInSensModifier
	
	var oldCameraRot = Vector2(cameraTarget.rotation_degrees.x, cameraTarget.rotation_degrees.y)
	#Quick fix for the camera rotation.
	var newCameraRot = Vector2(oldCameraRot.x - ((mouseVelocity.y * -1) * mouseModifier),\
								oldCameraRot.y - (mouseVelocity.x * mouseModifier))
	
	if(newCameraRot.x > lowerCameraLimitDegrees): newCameraRot.x = lowerCameraLimitDegrees
	if(newCameraRot.x < upperCameraLimitDegrees): newCameraRot.x = upperCameraLimitDegrees
	
	cameraTarget.rotation_degrees = Vector3(newCameraRot.x, newCameraRot.y, 0.0)
	horizontalRotPivot.rotation_degrees.y = newCameraRot.y
	mouseVelocity = Vector2.ZERO

func turn_body_to_camera(delta):
	var cameraRotation = horizontalRotPivot.rotation.y
	var oldPlayerRotation = rotation.y
	rotation.y = lerp_angle(oldPlayerRotation, cameraRotation, turnSpeed * delta)
	
	#Aiming logic below
	#if !IS_AIMING: return
	#var bonePose : Transform3D = skeleton.global_transform * skeleton.get_bone_global_pose(skelHeadIdx)
	#bonePose = bonePose.looking_at(bonePose.origin + get_viewport().get_camera_3d().basis.z)
	#skeleton.set_bone_global_pose_override(skelHeadIdx, skeleton.global_transform.affine_inverse() * bonePose, 1.0, true)

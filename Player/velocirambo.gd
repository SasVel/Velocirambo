extends CharacterBody3D
##Only affects walking speed in case it wasn't obvious.
@export var speed : float = 5.0
##Still unsure whether or not we will even keep the ability to jump.
@export var jumpVelocity : float = 4.5
##how fast the body tries to catch up to the camera
@export var turnSpeed : float = 25.0
##TODO Currently not being used
@export var turningDeadZoneDegrees : float = 15.0

##The default value is very low for now, because my Mouse has way too much DPI.
@export var mouseSensitivity : float = 1.7

##how far down can the camera look/how high can it go. This number should be negative.
@export var upperCameraLimitDegrees : float = -45.0
##how far up can the camera look/how low can it go. This number should be positive.
@export var lowerCameraLimitDegrees : float = 40.0

@export var cameraTarget : Marker3D
@export var horizontalRotPivot : Node3D

var mouseVelocity = Vector2.ZERO #Don't confuse with sensitivity

func _input(event):
	if event is InputEventMouseMotion:
		mouseVelocity = event.screen_relative

func _physics_process(delta):
	gravity(delta)
	turn_body_to_camera(delta)
	player_move(delta)
	camera_move(delta)

# Add the gravity. Hasn't been changed since script creation
func gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func player_move(_delta):
	# Do we need the ability to jump??? Letting it stay for now
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jumpVelocity

	# Get the input direction and handle the movement/deceleration.
	#This part hasn't changed much since script creation. Apart from the camera beeing used as the basis for movement
	var input_dir : Vector2 = Input.get_vector("Leftways", "Rightways", "Forwards", "Backwards")
	var direction = (horizontalRotPivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func camera_move(delta):
	cameraTarget.position = position
	camera_turn(delta)

#checks for the Limits and then turns the camera
func camera_turn(delta):
	if(Input.mouse_mode != Input.MOUSE_MODE_CAPTURED):
		return
	
	var oldCameraRot = Vector2(cameraTarget.rotation_degrees.x, cameraTarget.rotation_degrees.y)
	var newCameraRot = Vector2(oldCameraRot.x - (mouseVelocity.y * mouseSensitivity * delta),\
								oldCameraRot.y - (mouseVelocity.x * mouseSensitivity * delta))
	
	if(newCameraRot.x > lowerCameraLimitDegrees): newCameraRot.x = lowerCameraLimitDegrees
	if(newCameraRot.x < upperCameraLimitDegrees): newCameraRot.x = upperCameraLimitDegrees

	cameraTarget.rotation_degrees.y = newCameraRot.y
	cameraTarget.rotation_degrees.x = newCameraRot.x
	horizontalRotPivot.rotation_degrees.y = newCameraRot.y
	mouseVelocity = Vector2(0, 0)

func turn_body_to_camera(delta):
	var cameraRotation = horizontalRotPivot.rotation.y
	var oldPlayerRotation = rotation.y
	rotation.y = lerp_angle(oldPlayerRotation, cameraRotation, turnSpeed*delta)

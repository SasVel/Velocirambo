extends CharacterBody3D

@export var speed = 5.0
@export var jumpVelocity = 4.5

@export var mouseSensitivity = 0.5
@export var upperCameraLimitDegrees = -45.0 #how far down can the camera look/how high can it go
@export var lowerCameraLimitDegrees = 18.0 #how far up can the camera look/how low can it go

var mouseVelocity = Vector2(0, 0) #Don't confuse with sensitivity

func _input(event):
	if event is InputEventMouseMotion:
		mouseVelocity = event.screen_relative

func _physics_process(delta):
	gravity(delta)
	player_movement(delta)
	camera_movement(delta)

func gravity(delta):
	# Add the gravity. Unchanged from script creation
	if not is_on_floor():
		velocity += get_gravity() * delta

#This is all still for the most part the automatic script that godot gives you at script creation
func player_movement(delta):
	# Do we need the ability to jump??? Letting it stay for now
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jumpVelocity

	# Get the input direction and handle the movement/deceleration. Unchanged from script creation
	var input_dir = Input.get_vector("Leftways", "Rightways", "Forwards", "Backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

#TODO
func camera_movement(delta):
	if(Input.mouse_mode != Input.MOUSE_MODE_CAPTURED):
		return
	var oldCameraRotationY = $CameraTarget.rotation_degrees.y
	var oldCameraRotationX = $CameraTarget.rotation_degrees.x

	var newCameraRotationY = oldCameraRotationY - (mouseVelocity.x * mouseSensitivity)
	if(newCameraRotationY > 360): newCameraRotationY -= 360
	if(newCameraRotationY < -360): newCameraRotationY += 360

	var newCameraRotationX = oldCameraRotationX - (mouseVelocity.y * mouseSensitivity)
	if(newCameraRotationX > lowerCameraLimitDegrees): newCameraRotationX = lowerCameraLimitDegrees
	if(newCameraRotationX < upperCameraLimitDegrees): newCameraRotationX = upperCameraLimitDegrees

	print(newCameraRotationX)
	print(newCameraRotationY)
	$CameraTarget.rotation_degrees.y = newCameraRotationY
	$CameraTarget.rotation_degrees.x = newCameraRotationX
	mouseVelocity = Vector2(0, 0)

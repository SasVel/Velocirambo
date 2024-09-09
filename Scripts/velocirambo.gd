extends CharacterBody3D
##Only affects walking speed in case it wasn't obvious.
@export var speed = 5.0
##Still unsure whether or not we will even keep the ability to jump.
@export var jumpVelocity = 4.5
##how fast the body tries to catch up to the camera
@export var turnSpeed = 140.0
##area size of how much you can move the camera horizontally without the body turning towards it
@export var turningDeadZoneDegrees = 15.0

##The default value is very low for now, because my Mouse has way too much DPI.
@export var mouseSensitivity = 1.7

##how far down can the camera look/how high can it go. This number should be negative.
@export var upperCameraLimitDegrees = -45.0
##how far up can the camera look/how low can it go. This number should be positive.
@export var lowerCameraLimitDegrees = 18.0

var mouseVelocity = Vector2(0, 0) #Don't confuse with sensitivity

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


func player_move(delta):
	# Do we need the ability to jump??? Letting it stay for now
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jumpVelocity

	# Get the input direction and handle the movement/deceleration.
	#This part hasn't changed much since script creation. Apart from the camera beeing used as the basis for movement
	var input_dir = Input.get_vector("Leftways", "Rightways", "Forwards", "Backwards")
	var direction = ($"../CameraTarget".transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func camera_move(delta):
	$"../CameraTarget".position = position
	camera_turn(delta)


#checks for the Limits and then turns the camera
func camera_turn(delta):
	if(Input.mouse_mode != Input.MOUSE_MODE_CAPTURED):
		return
	var oldCameraRotationY = $"../CameraTarget".rotation_degrees.y
	var oldCameraRotationX = $"../CameraTarget".rotation_degrees.x

	var newCameraRotationY = oldCameraRotationY - (mouseVelocity.x * mouseSensitivity * delta)
	newCameraRotationY = limitTo360Range(newCameraRotationY)

	var newCameraRotationX = oldCameraRotationX - (mouseVelocity.y * mouseSensitivity * delta)
	if(newCameraRotationX > lowerCameraLimitDegrees): newCameraRotationX = lowerCameraLimitDegrees
	if(newCameraRotationX < upperCameraLimitDegrees): newCameraRotationX = upperCameraLimitDegrees

	$"../CameraTarget".rotation_degrees.y = newCameraRotationY
	$"../CameraTarget".rotation_degrees.x = newCameraRotationX
	mouseVelocity = Vector2(0, 0)

func turn_body_to_camera(delta):
	var cameraRotation = limitTo360Range($"../CameraTarget".rotation_degrees.y)
	var oldPlayerRotation = limitTo360Range(rotation_degrees.y)
	print("CameraRotation: ", cameraRotation)
	print("PlayerRotation: ", oldPlayerRotation)
	
	#stops function, if camera is in deadzone
	if((abs(cameraRotation - oldPlayerRotation) < turningDeadZoneDegrees/2) ||
	(abs(cameraRotation - oldPlayerRotation) > 360-turningDeadZoneDegrees/2)):
		print("Camera is in deadzone")
		return
	
	#calculates how many degrees you'd need if you were to rotate only with addition to the target rotation
	var positiveDifference
	if(oldPlayerRotation < cameraRotation):
		positiveDifference = cameraRotation - oldPlayerRotation
	else:
		positiveDifference = cameraRotation+360 - oldPlayerRotation
	
	#sets the shorter difference between additive and substractive rotation
	var shortestDifference
	if(positiveDifference <= 150.0):
		shortestDifference = positiveDifference
	else:
		shortestDifference = positiveDifference - 360
	
	#This will be probably subject to chance, Once I've got the actual modell to work with
	var newPlayerRotation
	var turnIncrement = turnSpeed * delta #Maybe this could be faster depending on how much rotation is left to do
	if(abs(shortestDifference) <= turnIncrement):
		newPlayerRotation = oldPlayerRotation + shortestDifference
	elif(shortestDifference >= 0):
		newPlayerRotation = oldPlayerRotation + turnIncrement
	else:
		newPlayerRotation = oldPlayerRotation - turnIncrement
	
	
	rotation_degrees.y = newPlayerRotation

func limitTo360Range(f):
	if(f > 360): f -= 360
	if(f < 0): f += 360
	return f

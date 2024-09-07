extends CharacterBody3D

@export var speed = 5.0
@export var jumpVelocity = 4.5

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
	pass

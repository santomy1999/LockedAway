extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var push_force = 20.0
var current_push_force = 0.0 # Holds the current force to be applied gradually
var push_decay_rate = 0.1 # Determines how fast the force decays (adjust as needed)

func _physics_process(delta: float) -> void:
	## Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor():
		var direction := Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * SPEED

	move_and_slide()
	
	# Apply gradual impulse
	if current_push_force > 0:
		apply_push_force(delta)

	# Check for collisions and initiate push force
	for i in range(get_slide_collision_count()):
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			# Start applying the push force gradually
			current_push_force = push_force # Set the initial force magnitude
			c.get_collider().apply_central_impulse(-c.get_normal() * current_push_force)

func apply_push_force(delta: float) -> void:
	# Gradually reduce the push force over time
	current_push_force -= push_decay_rate * delta
	if current_push_force < 0:
		current_push_force = 0 # Stop applying the force when it reaches zero

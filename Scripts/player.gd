class_name Player
extends CharacterBody2D
#
#
#@onready var animated_sprite_2d: AnimatedSprite2D = $Marker2D/AnimatedSprite2D
@onready var position_2d: Marker2D = $Marker2D
#
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
#
#const SPEED = 200.0
#const JUMP_VELOCITY = -400.0
#
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#var push_force = 20.0
#var current_push_force = 0.0 # Holds the current force to be applied gradually
#var push_decay_rate = 0.1 # Determines how fast the force decays (adjust as needed)
#var push_vector : Vector2 =Vector2(push_force,0)
#var is_grabbing:bool = false #Determines the if the player is grabing any object
#var direction = 0
#func _physics_process(delta: float) -> void:
	### Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
		#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#if is_on_floor():
		#direction = Input.get_axis("ui_left", "ui_right")
		#if(direction>0) && !is_grabbing:
			#position_2d.scale.x = 1
		#elif(direction <0) && !is_grabbing:
			#position_2d.scale.x = -1
			#
		#velocity.x = direction * SPEED
			#
		#if Input.is_action_pressed("action"):
			#grab_object()	
		#else: 
			#is_grabbing = false
			#
	#move_and_slide()
	#
	## Apply gradual impulse
	#if current_push_force > 0:
		#apply_push_force(delta)
	#object_collision()
	#
#
#func apply_push_force(delta: float) -> void:
	## Gradually reduce the push force over time
	#current_push_force -= push_decay_rate * delta
	#if current_push_force < 0:
		#current_push_force = 0 # Stop applying the force when it reaches zero
		#
#func object_collision()->void:
	## Check for collisions and initiate push force
	#for i in range(get_slide_collision_count()):
		#var c = get_slide_collision(i)
		#if c.get_collider() is RigidBody2D:
			## Start applying the push force gradually
			#current_push_force = push_force # Set the initial force magnitude
			#c.get_collider().apply_central_impulse(-c.get_normal() * current_push_force)
			#
#func grab_object() ->void:
	#if ray_cast_right.is_colliding():
		#var collider = ray_cast_right.get_collider()
		#if collider is RigidBody2D:
			#is_grabbing = true
			#collider.apply_central_impulse(push_vector*direction)
			#print(collider.name + str(direction))
			#
	#else:
		#pass

func check_for_item_vicinity()->int:
	if ray_cast_left.get_collider() is RigidBody2D:
		return -1
	elif ray_cast_right.get_collider() is RigidBody2D:
		return 1
	else:
		return 0

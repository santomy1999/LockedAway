extends State
class_name PlayerPushing

@onready var collision_shape: CollisionShape2D = $"../../CollisionShape2D"

@onready var ray_cast_right: RayCast2D = $"../../RayCastRight"
@onready var ray_cast_left: RayCast2D = $"../../RayCastLeft"

var SPEED = 80
var direction
var push_force = 2.0
var current_push_force = 0.0 # Holds the current force to be applied gradually
var push_decay_rate = 0.1 # Determines how fast the force decays (adjust as needed)
var push_vector : Vector2 =Vector2(push_force,0)
var is_grabbing:bool = false #Determines the if the player is grabing any object
var collider_handle :RigidBody2D


func enter():
	
	print("Pushing!")
func exit():
	#collider_handle.lock_rotation = false
	pass

func update(_delta:float):
	direction = Input.get_axis("left","right")
	if direction == player.check_for_item_vicinity():
		push_object()
	elif Input.is_action_pressed("action") && direction == -player.check_for_item_vicinity():
		grab_object()
	elif direction!=0:
		state_transition.emit(self,"Moving")
	else:
		state_transition.emit(self,"Idle")
	
	if(direction!=0):
		movePlayer(_delta,direction)
		if current_push_force > 0:
			get_push_force(_delta)
		
	
func get_push_force(delta: float) -> void:
	# Gradually reduce the push force over time
	current_push_force -= push_decay_rate * delta
	if current_push_force < 0:
		current_push_force = 0 # Stop applying the force when it reaches zero
		
func apply_push_force()->void:
	# Check for collisions and initiate push force
	for i in range(player.get_slide_collision_count()):
		var c = player.get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			# Start applying the push force gradually
			
			current_push_force = push_force # Set the initial force magnitude
			c.get_collider().apply_central_impulse(-c.get_normal() * current_push_force)
			
func push_object() ->void:
	var collider
	if ray_cast_right.get_collider() is RigidBody2D :
		collider = ray_cast_right.get_collider()
	elif ray_cast_left.get_collider() is RigidBody2D:
		collider = ray_cast_left.get_collider()
	else :
		return
	sprite.play("Pushing")
	collider_handle = collider
	current_push_force = push_force  # Set the initial force magnitude
	is_grabbing = false
	apply_push_force()
	#collider.apply_central_impulse(Vector2(1,0) * current_push_force * direction)
	#collider.lock_rotation = true
func grab_object():
	var collider
	if  ray_cast_right.get_collider() is RigidBody2D :
		collider = ray_cast_right.get_collider()
	elif ray_cast_left.get_collider() is RigidBody2D:
		collider = ray_cast_left.get_collider()	
	else:
		return
	sprite.play_backwards("Walking")
	is_grabbing = true
	collider_handle = collider
	current_push_force = push_force 
	collider.apply_central_impulse(Vector2(1,0) * current_push_force * direction)
	#collider.lock_rotation = true
	
func movePlayer(_delta:float,dir:int ):
	var item_direction = player.check_for_item_vicinity()
	if item_direction !=0:
		if Input.is_action_pressed("action") && is_grabbing:
			player.position_2d.scale.x = item_direction 
			
		else:
			player.position_2d.scale.x = -item_direction 
				


			
	player.velocity.x = dir * SPEED
	if not player.is_on_floor():
		state_transition.emit(self,"Falling")
	player.move_and_slide()

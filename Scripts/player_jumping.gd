class_name PlayerJump
extends State

@export var JUMP_VELOCITY = -450
var MID_AIR_SPEED = 50
var dir 
var already_moving
@onready var jumpTimer:Timer = $JumpTimer
func enter():
	jumpTimer.start()
	print("Jumping!")
	sprite.play("Jumping")
	print("Jumping!"+str(player.velocity.y))
	already_moving = Input.get_axis("left", "right") !=0
	player.velocity.y = JUMP_VELOCITY  # Set jump velocity when entering state
func exit():
	pass
	

func update(_delta:float):
	dir = Input.get_axis("left", "right")
	player.move_and_slide()
	if not player.is_on_floor():
		player.velocity.y += gravity * _delta
		if  dir != 0:
			player.position_2d.scale.x = dir
		if dir!= 0 && not already_moving:
			move_player_mid_air(_delta)
	if player.is_on_floor():
		# If player is on the floor, transition to appropriate state
		if dir != 0:
			print("is on floor moving")
			state_transition.emit(self, "Moving")
		else:
			print("is on floor idle")
			state_transition.emit(self, "Idle")
		
func _on_jump_timer_timeout() -> void:
	print("timedout")
	state_transition.emit(self,"Falling")
	
func move_player_mid_air(_delta:float ):
	player.position_2d.scale.x = dir
	player.velocity.x = dir * MID_AIR_SPEED
	if not player.is_on_floor():
		state_transition.emit(self,"Falling")
	player.move_and_slide()

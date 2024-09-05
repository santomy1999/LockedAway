class_name PlayerFalling
extends State

func enter():
	sprite.play("Falling")
	print("Falling!")
func exit():
	pass

func update(_delta:float):
	if not player.is_on_floor():
		player.velocity.y += gravity * _delta
	elif Input.get_axis("left", "right") != 0:
		state_transition.emit(self,"Moving")
	else:
		state_transition.emit(self,"Idle")
		
	player.move_and_slide()

extends State
class_name PlayerIdle

func enter():
	sprite.play("Idle")
	print("Idle!")

func update(_delta: float) -> void:
	if Input.get_axis("left", "right") != 0:
		state_transition.emit(self, "Moving")
	else:
		player.velocity.x = 0

	if not player.is_on_floor():
		state_transition.emit(self, "Falling")
		return

	if Input.is_action_just_pressed("Up"):
		print("Up pressed")
		state_transition.emit(self, "Jumping")
	if Input.is_action_pressed("action") && player.check_for_item_vicinity()!=0:
		state_transition.emit(self, "Pushing")

func exit():
	pass

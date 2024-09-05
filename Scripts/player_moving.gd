extends State
class_name PlayerMoving



@export var SPEED = 200.0
var direction


func enter() :
	print("Moving!")

	if !player:
		print("Player not  found")
	sprite.play("Running")
	pass
	
func update(_delta:float)->void:
	direction = Input.get_axis("left", "right")
	if(direction != 0):
		movePlayer(_delta,direction)
		#pass
	else:
		state_transition.emit(self,"Idle")
	if(Input.is_action_just_pressed("Up")) :
		state_transition.emit(self,"Jumping")
		pass
	if Input.is_action_pressed("action") && player.check_for_item_vicinity()!=0:
		state_transition.emit(self, "Pushing")
	if player.check_for_item_vicinity() ==direction:
		state_transition.emit(self, "Pushing")
func exit():
	pass

func movePlayer(_delta:float,dir:int ):
	player.position_2d.scale.x = dir
	player.velocity.x = direction * SPEED
	if not player.is_on_floor():
		state_transition.emit(self,"Falling")
	player.move_and_slide()

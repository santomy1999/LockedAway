class_name StateMachine
extends Node

var current_state : State
var states:Dictionary = {}
@export var initial_state : State



func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)	
	if initial_state:
			initial_state.enter()
			current_state = initial_state
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
	else:
		pass
func change_state(source_state :State , new_state_name : String):
	if source_state!=current_state:
		print("Not inside the state from which you are trying to transiton from")
		print("Source state:" + source_state.name + "\nNewState:" + new_state_name)
		
		return
	var new_state  = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state null")
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	
	current_state = new_state
	
	

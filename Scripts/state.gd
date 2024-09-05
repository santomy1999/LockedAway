class_name State
extends Node

@warning_ignore("unused_signal")
signal  state_transition

@export
var sprite : AnimatedSprite2D

var gravity :float = ProjectSettings.get_setting("physics/2d/default_gravity")

@export
var animation_name: String
@onready var player: Player = %PlayerBody

var parent: Player

func enter():
	pass
	
func exit():
	pass

func update(_delta:float):
	pass

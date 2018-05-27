extends "res://Character/Character.gd"

var current_state

enum STATE_ { NULL, IDLE, WALK }

onready var state_nodes = {
	STATE_.IDLE: $States/Idle,
	STATE_.WALK: $States/Walk
}

func _ready():
	current_state = state_nodes[STATE_.IDLE]
	current_state.enter()
	pass
	
func _physics_process(delta):
	var new_state = current_state.update(delta)
	if new_state:
		current_state.exit()
		current_state = state_nodes[new_state]
		current_state.enter()
	
func _input(event):
	var new_state = current_state.handleInput(event)
	if new_state:
		current_state.exit()
		current_state = state_nodes[new_state]
		current_state.enter()

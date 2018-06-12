extends KinematicBody2D

enum STATE { NULL, IDLE }

# State Machine
var current_state

onready var state_nodes = {
	STATE.IDLE: $States/Idle,
}

func _ready():
	# Process state machine
	current_state = state_nodes[STATE.IDLE]
	current_state.enter(self)
	
func _physics_process(delta):
	# Process state machine
	var new_state = current_state.update(self, delta)
	if new_state:
		current_state.exit(self)
		current_state = state_nodes[new_state]
		current_state.enter(self)
	
func _input(event):
	# Process state machine
	var new_state = current_state.handleInput(self, event)
	if new_state:
		current_state.exit(self)
		current_state = state_nodes[new_state]
		current_state.enter(self)

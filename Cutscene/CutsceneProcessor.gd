extends KinematicBody2D

enum STATE { NULL, IDLE, SHOW_TEXT, WAIT }

var cutscene_array = []

# State Machine
var current_state

onready var state_nodes = {
	STATE.IDLE: $States/Idle,
	STATE.SHOW_TEXT: $States/show_text,
	STATE.WAIT: $States/wait,
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

func process_next_index():
	if cutscene_array.empty():
		return STATE.IDLE
		
	var next_item = cutscene_array.pop_front()
	if next_item[0] == "show_text":
		return STATE.SHOW_TEXT
	elif next_item[0] == "wait":
		return STATE.WAIT
	
	return STATE.IDLE
		
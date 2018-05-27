extends "res://Character/Character.gd"

var current_state

func _ready():
	current_state = $States/Idle
	current_state.enter()
	pass
	
func _physics_process(delta):
	var new_state = current_state.update(delta)
	if new_state:
		current_state.exit()
		current_state = new_state
		new_state.enter()
	
func _input(event):
	var new_state = current_state.handleInput(event)
	if new_state:
		current_state.exit()
		current_state = new_state
		new_state.enter()
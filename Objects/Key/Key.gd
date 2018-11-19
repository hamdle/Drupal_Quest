extends KinematicBody2D

enum STATE { NULL, HIDE, SHOW, CARRY, THROW }

const TAG = "Key"
# Physics and Jump
var motion = Vector2()
var character

# State Machine
var current_state

# Key mechanics
var spawn_position = Vector2()

onready var state_nodes = {
	STATE.HIDE: $States/Hide,
	STATE.SHOW: $States/Show,
	STATE.CARRY: $States/Carry,
	STATE.THROW: $States/Throw
}

func _ready():
	# Set animation
	$AnimationPlayer.play("SETUP")
	
	# Disabled by default
	
	# Process state machine
	current_state = state_nodes[STATE.HIDE]
	current_state.enter(self)
	pass
	
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
	
func flip_sprite(flip):
	$Position2D/Sprite.flip_h = flip

func set_character(character):
	self.character = character

func throw():
	current_state.exit(self)
	current_state = state_nodes[STATE.THROW]
	current_state.enter(self)

func _on_Enemy_die(pos):
	var e = get_tree().get_nodes_in_group("enemies")
	if e.size() == 0:
		spawn_position = pos
		current_state.exit(self)
		current_state = state_nodes[STATE.SHOW]
		current_state.enter(self)
	
func _on_AnimationPlayer_animation_finished(anim_name):
	# This function runs when any character animation is finished
	# DOES NOT RUN if animation is set to loop
	pass
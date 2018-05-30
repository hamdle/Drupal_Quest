extends KinematicBody2D

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }

# Physics and Jump
var motion = Vector2()

# AI system
var patrol_origin = Vector2()

# State Machine
var current_state

onready var state_nodes = {
	STATE.IDLE: $States/Idle,
	STATE.PATROL: $States/Patrol,
	STATE.ATTACK: $States/Attack,
	STATE.DIE: $States/Die
}

func _ready():
	# Set animation
	$AnimationPlayer.play("SETUP")
	
	# Process state machine
	current_state = state_nodes[STATE.IDLE]
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

func set_patrol_origin():
	patrol_origin = transform.origin

func _on_AnimationPlayer_animation_finished(anim_name):
	# This function runs when any character animation is finished
	# DOES NOT RUN if animation is set to loop
	pass
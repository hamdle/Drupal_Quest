extends KinematicBody2D

# Physics and Jump
var motion = Vector2()
var mouse_press = Vector2()
var launch_velocity = Vector2()

# State Machine
var current_state
enum STATE { NULL, IDLE, WALK, JUMP, LAUNCH }

onready var state_nodes = {
	STATE.IDLE: $States/Idle,
	STATE.WALK: $States/Walk,
	STATE.JUMP: $States/Jump,
	STATE.LAUNCH: $States/Launch
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
		current_state.exit()
		current_state = state_nodes[new_state]
		current_state.enter(self)
	
func _input(event):
	# Process state machine
	var new_state = current_state.handleInput(self, event)
	if new_state:
		current_state.exit()
		current_state = state_nodes[new_state]
		current_state.enter(self)
	
func flip_sprite(flip):
	$Position2D/Sprite.flip_h = flip
	
func calculate_launch_velocity(mouse_press, mouse_release):
	var dir_x = mouse_press.x - mouse_release.x
	var dir_y = mouse_press.y - mouse_release.y
	var factor = sqrt(pow(dir_x, 2) + pow(dir_y, 2))
	launch_velocity = Vector2(dir_x * factor, dir_y * factor)
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	# This function runs when any character animation is finished
	# DOES NOT RUN if animation is set to loop
	pass
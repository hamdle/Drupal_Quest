extends KinematicBody2D

# Physics and Jump
var motion = Vector2()
var mouse_press = Vector2()
var mouse_release = Vector2()

# State Machine
var current_state
enum STATE { NULL, IDLE, WALK, JUMP }

onready var state_nodes = {
	STATE.IDLE: $States/Idle,
	STATE.WALK: $States/Walk,
	STATE.JUMP: $States/Jump,
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
	# Mouse event processing
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_button"):
			mouse_press = event.position
		if event.is_action_released("mouse_button"):
			mouse_release = event.position
			process_mouse_input()
	
	# Process state machine
	var new_state = current_state.handleInput(event)
	if new_state:
		current_state.exit()
		current_state = state_nodes[new_state]
		current_state.enter(self)
	
func flip_sprite(flip):
	$Position2D/Sprite.flip_h = flip

func process_mouse_input():
	var dir_x = mouse_press.x - mouse_release.x
	var dir_y = mouse_press.y - mouse_release.y
	var distance = sqrt(pow(dir_x, 2) + pow(dir_y, 2))
	print(distance)
	

func _on_AnimationPlayer_animation_finished(anim_name):
	# This function runs when any character animation is finished
	# DOES NOT RUN if animation is set to loop
	pass
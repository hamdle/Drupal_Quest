extends KinematicBody2D

enum STATE { NULL, IDLE, WALK, JUMP, LAUNCH, WIN, DIE }

const MOUSE_RESET = Vector2(-1, -1)

# Physics and Jump
var motion = Vector2()
var mouse_press = Vector2()
var mouse_release = Vector2()
# Key
var has_key = false

# State Machine
var current_state

onready var state_nodes = {
	STATE.IDLE: $States/Idle,
	STATE.WALK: $States/Walk,
	STATE.JUMP: $States/Jump,
	STATE.LAUNCH: $States/Launch,
	STATE.WIN: $States/Win,
	STATE.DIE: $States/Die
}

func _ready():
	# Set animation
	$AnimationPlayer.play("SETUP")
	# Clear mouse input
	mouse_press = MOUSE_RESET
	
	# Process state machine
	current_state = state_nodes[STATE.IDLE]
	current_state.enter(self)
	pass

func _process(delta):
	update()
	
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

func _draw():
	# Visualize launcher
	var line_size = 10
	var line_color = Color(100, 100, 100)
	if current_state == state_nodes[STATE.IDLE]:
		if mouse_press != MOUSE_RESET:
			#print("mouse press: " + String(get_viewport().get_mouse_position()))
			#print($Camera2D.get_camera_position ( ))
			#print("position: " + String(to_local(position)))
			#print("mp - p: " + String(mouse_press - position))
			#var v = Vector2(mouse_press.x, $Camera2D.get_camera_position().y - mouse_press.y)
			#draw_circle(to_local(v), line_size / 2, Color(255,0,0))
			draw_circle(position, line_size / 2, Color(0,255,0))
			draw_circle(mouse_press - position, line_size / 2, line_color)
			draw_line(mouse_press - position, \
			get_viewport().get_mouse_position() - position, \
			line_color, line_size)
	
func flip_sprite(flip):
	$Position2D/Sprite.flip_h = flip

# Exit entered signal
func _on_Exit_entered():
	if has_key:
		if not current_state == state_nodes[STATE.WIN]:
			current_state.exit(self)
			current_state = state_nodes[STATE.WIN]
			current_state.enter(self)
	pass

func _on_Player_damage():
	current_state.exit(self)
	current_state = state_nodes[STATE.DIE]
	current_state.enter(self)

func _on_AnimationPlayer_animation_finished(anim_name):
	# This function runs when any character animation is finished
	# DOES NOT RUN if animation is set to loop
	pass
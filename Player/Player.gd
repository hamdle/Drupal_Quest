extends KinematicBody2D

enum STATE { NULL, IDLE, WALK, JUMP, LAUNCH, WIN, DIE }

const TAG = "Player"
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
	$AnimationPlayer.play("FLOAT")
	# Clear mouse input
	mouse_press = MOUSE_RESET
	
	# Load character
	load_character()
	
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
	var line_size = 1
	var line_color = Color(0, 255, 0)
	if current_state == state_nodes[STATE.IDLE]:
		if mouse_press != MOUSE_RESET:
			# Get the distance
			var distance_vector = self.get_global_mouse_position() - mouse_press
			# Adjust y for global position of player
			var y_dif = self.get_global_transform_with_canvas().get_origin().y -  global_position.y
			distance_vector.y = distance_vector.y + y_dif
			# Reflect the line
			distance_vector.x = -distance_vector.x
			distance_vector.y = -distance_vector.y
			
			# Draw the line
			draw_line(to_local(position), \
			distance_vector, \
			line_color, line_size)
			
			# Draw the mouse click
			var mouse_press_adjusted = to_local(mouse_press)
			mouse_press_adjusted.y = mouse_press_adjusted.y - y_dif
			draw_circle(mouse_press_adjusted, 20, Color(255,0,255))
	
func flip_sprite(flip):
	$Position2D/Sprite.flip_h = flip

func load_character():
	var gs = get_node("/root/gamestate")
	if gs.current_character == gs.CHARACTER.CLASSIC:
		$Position2D/Sprite.texture = $Position2D/Sprite.drupal_texture
	elif gs.current_character == gs.CHARACTER.DRUPAL8:
		$Position2D/Sprite.texture = $Position2D/Sprite.drupal_8_texture
	elif gs.current_character == gs.CHARACTER.JUMPAL:
		$Position2D/Sprite.texture = $Position2D/Sprite.drupal_quest_texture
	
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
	if anim_name == "LAND":
		$AnimationPlayer.play("FLOAT")
	pass
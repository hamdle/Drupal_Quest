extends Node

enum STATE { NULL, IDLE, WALK, JUMP, LAUNCH, WIN, DIE }

const MOUSE_RESET = Vector2(-1, -1)
const UP = Vector2(0, -1)
const GRAVITY = 12
const ACCELERATION = 20
const MAX_SPEED = 200
const FLOOR_FRICTION = 0.2
const AIR_FRICTION = 0.1

export var vertical_scale = 0.1
export var horizontal_scale = 0.1
export var max_vertical_launch = 900
export var max_horizontal_launch = 300

# False launch happens when the player clicks
# and releases but never moves the mouse
var false_launch = false

func enter(player):
	print(player.name + " LAUNCH")
	var gs = get_node("/root/gamestate")
	gs.local_launches += 1
	
	false_launch = false
	
	if player.is_on_floor():
		player.motion = calculate_launch_velocity(player.mouse_press, player.mouse_release)
		# player.motion = calculate_launch_velocity(player.position, player.mouse_release)
		
		if player.motion == Vector2(0, 0):
			false_launch = true
		else:
			player.get_node("AnimationPlayer").play("SETUP")
			player.get_node("GroundCollisionShape2D").disabled = true

func exit(player):
	player.mouse_press = MOUSE_RESET
	
	if false_launch == false:
		player.get_node("GroundCollisionShape2D").disabled = false
		var player_animation = player.get_node("AnimationPlayer")
		# player_animation.seek(0)
		player_animation.play("LAND")
	
func update(player, delta):
	#Gravity
	player.motion.y += GRAVITY
	
	# Controls
	if Input.is_action_pressed("move_right"):
		player.motion.x = min(player.motion.x + ACCELERATION, MAX_SPEED)
		player.flip_sprite(false)
	elif Input.is_action_pressed("move_left"):
		player.motion.x = max(player.motion.x - ACCELERATION, -MAX_SPEED)
		player.flip_sprite(true)
		
	# Process movement using Godot physics system
	player.motion = player.move_and_slide(player.motion, UP)
	
	# Process states. This must be AFTER move_and_slide
	if player.is_on_floor():
		return STATE.IDLE
	pass
	
func handleInput(player, event):
	if Input.is_action_pressed("throw"):
		player.throw_key()

func calculate_launch_velocity(mouse_press, mouse_release):
	# Calculate velocity
	var dir_x = mouse_press.x - mouse_release.x
	var dir_y = mouse_press.y - mouse_release.y
	var factor = sqrt(pow(dir_x, 2) + pow(dir_y, 2))
	var launch_velocity = Vector2(dir_x * factor, dir_y * factor)
	
	# Scale for launch
	launch_velocity.y = min(max(launch_velocity.y * vertical_scale, -max_vertical_launch), 0)
	if launch_velocity.x >= 0:
		launch_velocity.x = min(launch_velocity.x * horizontal_scale, max_horizontal_launch)
	else:
		launch_velocity.x = max(launch_velocity.x * horizontal_scale, -max_horizontal_launch)
	
	# No launching down - causes buggy behavior
	if launch_velocity.y == 0:
		launch_velocity.x = 0
	
	return launch_velocity
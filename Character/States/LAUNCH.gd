extends Node

enum STATE { NULL, IDLE, WALK, JUMP, LAUNCH }

const UP = Vector2(0, -1)
const GRAVITY = 12
const ACCELERATION = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = 300
const FLOOR_FRICTION = 0.2
const AIR_FRICTION = 0.1

func enter(player):
	print("LAUNCH")
	if player.is_on_floor():
		player.motion = player.launch_velocity
	pass

func exit():
	pass
	
func update(player, delta):
	#Gravity
	player.motion.y += GRAVITY
	
	# Process movement using Godot physics system
	player.motion = player.move_and_slide(player.motion, UP)
	
	# Process states. This must be AFTER move_and_slide
	if player.is_on_floor():
		return STATE.IDLE
	pass
	
func handleInput(player, event):
	pass

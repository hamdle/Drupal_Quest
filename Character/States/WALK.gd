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
	print("WALK")
	pass

func exit():
	pass
	
func update(player, delta):
	#Gravity
	player.motion.y += GRAVITY
	
	var friction = false
	
	# Controls
	if Input.is_action_pressed("move_right"):
		player.motion.x = min(player.motion.x + ACCELERATION, MAX_SPEED)
		player.flip_sprite(false)
	elif Input.is_action_pressed("move_left"):
		player.motion.x = max(player.motion.x - ACCELERATION, -MAX_SPEED)
		player.flip_sprite(true)
	else:
		 return STATE.IDLE # friction = true
		
	# Process movement using Godot physics system
	player.motion = player.move_and_slide(player.motion, UP)
	pass
	
func handleInput(player, event):
	if Input.is_action_just_pressed("jump"):
		return STATE.JUMP
	#if not Input.is_action_pressed("move_right") or \
	#not Input.is_action_pressed("move_left"):
	#	return STATE.IDLE
	pass

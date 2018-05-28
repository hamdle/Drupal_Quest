extends Node

enum STATE { NULL, IDLE, WALK, JUMP }

const UP = Vector2(0, -1)
const GRAVITY = 12
const ACCELERATION = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = 300
const FLOOR_FRICTION = 0.2
const AIR_FRICTION = 0.1

func enter(player):
	print("IDLE")
	pass

func exit():
	pass
	
func update(player, delta):
	#Gravity
	player.motion.y += GRAVITY
	
	#Apply floor friction
	player.motion.x = lerp(player.motion.x, 0, FLOOR_FRICTION)
	
	# Process movement using Godot physics system
	player.motion = player.move_and_slide(player.motion, UP)
	pass
	
func handleInput(event):
	if Input.is_action_pressed("move_right"):
		return STATE.WALK
	if Input.is_action_pressed("move_left"):
		return STATE.WALK
	if Input.is_action_just_pressed("jump"):
		return STATE.JUMP
	pass

extends Node

enum STATE { NULL, IDLE, WALK, JUMP, LAUNCH, WIN, DIE }

const MOUSE_RESET = Vector2(-1, -1)
const UP = Vector2(0, -1)
const GRAVITY = 12
const ACCELERATION = 20
const MAX_SPEED = 200
const FLOOR_FRICTION = 0.2
const AIR_FRICTION = 0.1

func enter(player):
	print(player.name + " IDLE")
	
	pass

func exit(player):
	pass
	
func update(player, delta):
	#Gravity
	player.motion.y += GRAVITY
	
	#Apply floor friction
	player.motion.x = lerp(player.motion.x, 0, FLOOR_FRICTION)
	
	# Process movement using Godot physics system
	player.motion = player.move_and_slide(player.motion, UP)
	pass
	
func handleInput(player, event):
	# Player launch inputs
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_button"):
			player.mouse_press = event.position
		if event.is_action_released("mouse_button"):
			player.mouse_release = event.position
			# Make sure we captured a press too
			if player.mouse_press != MOUSE_RESET:
				return STATE.LAUNCH
			
	# Check movement keys to set state change
	if Input.is_action_pressed("move_right"):
		return STATE.WALK
	if Input.is_action_pressed("move_left"):
		return STATE.WALK
	if Input.is_action_just_pressed("jump"):
		return STATE.JUMP
	if Input.is_action_pressed("throw"):
		player.throw_key()
	pass

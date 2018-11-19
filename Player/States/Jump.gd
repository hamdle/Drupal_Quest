extends Node

enum STATE { NULL, IDLE, WALK, JUMP, LAUNCH, WIN, DIE }

const UP = Vector2(0, -1)
const GRAVITY = 12
const ACCELERATION = 20
const MAX_SPEED = 200
const FLOOR_FRICTION = 0.2
const AIR_FRICTION = 0.1

export var jump_height = 325

func enter(player):
	print(player.name + " JUMP")
	var gs = get_node("/root/gamestate")
	gs.local_jumps += 1
	
	if player.is_on_floor():
		player.motion.y = -jump_height
		player.get_node("AnimationPlayer").play("SETUP")
		player.get_node("GroundCollisionShape2D").disabled = true
		

func exit(player):
	player.get_node("GroundCollisionShape2D").disabled = false
	var player_animation = player.get_node("AnimationPlayer")
	# player_animation.seek(0)
	player_animation.play("LAND")
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
		friction = true
		
	# Apply air friction if player is in the air and
	# lets go of the move key
	if not Input.is_action_pressed("move_right") and \
	not Input.is_action_pressed("move_left"):
		player.motion.x = lerp(player.motion.x, 0, AIR_FRICTION)
	
	# Process movement using Godot physics system
	player.motion = player.move_and_slide(player.motion, UP)
	
	if player.is_on_floor():
		if friction == false:
			return STATE.WALK
		else:
			return STATE.IDLE
	pass
	
func handleInput(player, event):
	if Input.is_action_pressed("throw"):
		player.throw_key()

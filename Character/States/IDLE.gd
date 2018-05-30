extends Node

enum STATE { NULL, IDLE, WALK, JUMP, LAUNCH }

const UP = Vector2(0, -1)
const GRAVITY = 12
const ACCELERATION = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = 300
const FLOOR_FRICTION = 0.2
const AIR_FRICTION = 0.1

# Slingshot jump
var mouse_press = Vector2()
var mouse_release = Vector2()

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
	
func handleInput(player, event):
	# Slingshot jump processing
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_button"):
			mouse_press = event.position
		if event.is_action_released("mouse_button"):
			mouse_release = event.position
			var dir_x = mouse_press.x - mouse_release.x
			var dir_y = mouse_press.y - mouse_release.y
			var factor = sqrt(pow(dir_x, 2) + pow(dir_y, 2))
			player.launch_velocity = Vector2(dir_x * factor, dir_y * factor)
			return STATE.LAUNCH
			
	# Check movement keys to set state change
	if Input.is_action_pressed("move_right"):
		return STATE.WALK
	if Input.is_action_pressed("move_left"):
		return STATE.WALK
	if Input.is_action_just_pressed("jump"):
		return STATE.JUMP
	pass

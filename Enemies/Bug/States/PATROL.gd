extends Node

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }
enum DIR { LEFT, RIGHT }

const UP = Vector2(0, -1)
const GRAVITY = 12
const ACCELERATION = 10
const MAX_SPEED = 80

export var patrol_distance = 200

var current_dir = DIR.LEFT

func enter(bug):
	print(bug.name + " PATROL")
	pass

func exit(bug):
	pass
	
func update(bug, delta):
	#Gravity
	bug.motion.y += GRAVITY
	
	# Move right
	if current_dir == DIR.RIGHT:
		bug.motion.x = min(bug.motion.x + ACCELERATION, MAX_SPEED)
		bug.flip_sprite(false)
		if bug.position.x > bug.patrol_origin.x + patrol_distance:
			current_dir = DIR.LEFT
	# Move left
	if current_dir == DIR.LEFT:
		bug.motion.x = max(bug.motion.x - ACCELERATION, -MAX_SPEED)
		bug.flip_sprite(true)
		if bug.position.x < bug.patrol_origin.x - patrol_distance:
			current_dir = DIR.RIGHT
	
	# Process movement using Godot physics system
	bug.motion = bug.move_and_slide(bug.motion, UP)
	pass
	
func handleInput(bug, event):
	pass

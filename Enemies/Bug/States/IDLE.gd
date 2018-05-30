extends Node

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }

const UP = Vector2(0, -1)
const GRAVITY = 12

export var carry_offset = Vector2(0, -50)

func enter(bug):
	print(bug.name + " IDLE")
	pass

func exit(bug):
	pass
	
func update(bug, delta):
	#Gravity
	bug.motion.y += GRAVITY
	
	# Process movement using Godot physics system
	bug.motion = bug.move_and_slide(bug.motion, UP)
	
	if bug.is_on_floor():
		bug.set_patrol_origin()
		return STATE.PATROL
	
func handleInput(bug, event):
	pass

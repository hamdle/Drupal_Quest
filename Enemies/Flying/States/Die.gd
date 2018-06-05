extends Node

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }

const UP = Vector2(0, -1)
const GRAVITY = 12

func enter(flying):
	print(flying.name + " DIE")
	
	flying.motion.x = 0
	flying.die()
	pass

func exit(flying):
	pass
	
func update(flying, delta):
	#Gravity
	flying.motion.y += GRAVITY
	
	if flying.is_on_floor():
		return STATE.IDLE
	
	# Process movement using Godot physics system
	flying.motion = flying.move_and_slide(flying.motion, UP)
	
func handleInput(flying, event):
	pass

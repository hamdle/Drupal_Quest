extends Node

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }

const UP = Vector2(0, -1)
const GRAVITY = 0

func enter(flying):
	print(flying.name + " ATTACK")
	pass

func exit(flying):
	pass
	
func update(flying, delta):
	#Gravity
	flying.motion.y += GRAVITY
	
	# Process movement using Godot physics system
	flying.motion = flying.move_and_slide(flying.motion, UP)
	
func handleInput(flying, event):
	pass

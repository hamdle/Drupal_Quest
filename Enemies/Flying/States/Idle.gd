extends Node

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }

const UP = Vector2(0, -1)
const GRAVITY = 0
const FLOOR_FRICTION = 0.2

func enter(flying):
	print(flying.name + " IDLE")
	
	flying.motion = Vector2()
	pass

func exit(flying):
	pass
	
func update(flying, delta):
	#Gravity
	flying.motion.y += GRAVITY
	
	#Apply floor friction
	if flying.is_on_floor():
		flying.motion.x = lerp(flying.motion.x, 0, FLOOR_FRICTION)
		
	# Process movement using Godot physics system
	flying.motion = flying.move_and_slide(flying.motion, UP)
	
func handleInput(flying, event):
	pass

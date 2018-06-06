extends Node

enum STATE { NULL, HIDE, SHOW, CARRY }

const UP = Vector2(0, -1)
const GRAVITY = 12

func enter(key):
	print(key.name + " SHOW")
	
	var adjusted_pos = Vector2(key.spawn_position.x, key.spawn_position.y + -200)
	key.position = adjusted_pos
	key.motion.y = -200
	pass

func exit(key):
	pass
	
func update(key, delta):
	#Gravity
	key.motion.y += GRAVITY
	
	# Poll Area2D for Character collision
	var area = key.get_node("Area2D")
	for body in area.get_overlapping_bodies():
		if body.name == "Player":
			key.set_character(body)
			return STATE.CARRY
			
	# Process movement using Godot physics system
	key.motion = key.move_and_slide(key.motion, UP)
	pass
	
func handleInput(key, event):
	pass

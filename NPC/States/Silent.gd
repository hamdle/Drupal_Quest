extends Node

enum STATE { NULL, SILENT, TALK }

const UP = Vector2(0, -1)
const GRAVITY = 12
const FLOOR_FRICTION = 0.2

func enter(npc):
	print(npc.name + " SILENT")

	pass

func exit(npc):
	pass
	
func update(npc, delta):
	#Gravity
	npc.motion.y += GRAVITY
	
	# Poll Area2D for Character collision
	var area = npc.get_node("Area2D")
	for body in area.get_overlapping_bodies():
		if body.name == "Player":
			return STATE.TALK
			
	#Apply floor friction
	if npc.is_on_floor():
		npc.motion.x = lerp(npc.motion.x, 0, FLOOR_FRICTION)
	
	# Process movement using Godot physics system
	npc.motion = npc.move_and_slide(npc.motion, UP)
	pass
	
func handleInput(npc, event):
	pass

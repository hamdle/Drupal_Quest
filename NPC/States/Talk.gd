extends Node

enum STATE { NULL, SILENT, TALK }

const UP = Vector2(0, -1)
const GRAVITY = 12
const FLOOR_FRICTION = 0.2

func enter(npc):
	print(npc.name + " TALK")

	var text = npc.get_node("Text")
	text.visible = true
	# text.set("custom_colors/font_color", Color(255, 255, 255))
	# text.add_color_override("font_color", Color(0, 255, 0))
	pass

func exit(npc):
	var text = npc.get_node("Text")
	text.visible = false
	pass
	
func update(npc, delta):
	#Gravity
	npc.motion.y += GRAVITY
	
	# Poll Area2D for Character collision
	var keep_talking = false
	var area = npc.get_node("Area2D")
	for body in area.get_overlapping_bodies():
		if body.name == "Player":
			keep_talking = true
	
	if keep_talking == false:
		return STATE.SILENT
			
	#Apply floor friction
	if npc.is_on_floor():
		npc.motion.x = lerp(npc.motion.x, 0, FLOOR_FRICTION)
	
	# Process movement using Godot physics system
	npc.motion = npc.move_and_slide(npc.motion, UP)
	pass
	
func handleInput(npc, event):
	pass

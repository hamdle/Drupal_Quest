extends Node

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }

const UP = Vector2(0, -1)
const GRAVITY = 12

func enter(flying):
	print(flying.name + " DIE")
	
	flying.motion.x = 0
	flying.motion.y = 0
	flying.die()
	pass

func exit(flying):
	pass
	
func update(flying, delta):
	#Gravity
	flying.motion.y += GRAVITY
	
	# Cause damage to bugs while falling
	var cause_damage = flying.get_node("CauseDamageArea2D")
	for body in cause_damage.get_overlapping_bodies():
		if ("TAG" in body): # If TAG exists
			if body.TAG == "Bug": # If the TAG is a Bug
				if not (body.current_state == body.state_nodes[body.STATE.DIE]): # Check the state
					flying.emit_bug_damage_signal(body.name)
			
	if flying.is_on_floor():
		var col = flying.get_node("CollisionShape2D")
		col.disabled = true
		return STATE.IDLE
	
	# Process movement using Godot physics system
	flying.motion = flying.move_and_slide(flying.motion, UP)
	
func handleInput(flying, event):
	pass

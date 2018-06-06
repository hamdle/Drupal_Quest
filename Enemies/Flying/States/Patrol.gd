extends Node

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }

const UP = Vector2(0, -1)
const GRAVITY = 0

export var plot_scale = Vector2(100, 100)
export var plot_start = 0.0
export var plot_end = 1.0
export var plot_step = 0.1

var points = Array()
var move_count = 0

func enter(flying):
	print(flying.name + " PATROL")
	
	# Plot the path
	lemniscate_of_bernoulli()
	pass

func exit(flying):
	pass
	
func update(flying, delta):
	#Gravity
	flying.motion.y += GRAVITY
	
	# Sprite direction
	if flying.motion.x > 0:
		flying.flip_sprite(false)
	elif flying.motion.x < 0:
		flying.flip_sprite(true)
		
	# Cause damage
	var cause_damage = flying.get_node("CauseDamageArea2D")
	for body in cause_damage.get_overlapping_bodies():
		if ("TAG" in body): # If TAG exists
			if body.TAG == "Player":
				flying.emit_player_damage_signal()
	# Take damage
	var take_damage = flying.get_node("TakeDamageArea2D")
	for body in take_damage.get_overlapping_bodies():
		if ("TAG" in body): # If TAG exists
			if body.TAG == "Player":
				return STATE.DIE
		
	# Process movement using Godot physics system
	flying.motion = flying.move_and_slide(get_next_vector(), UP)
	
func handleInput(flying, event):
	pass

func lemniscate_of_bernoulli():
	var new_pos = Vector2()
	var t = self.plot_start
	while t <= self.plot_end:
		var scale = 2 / (3 - cos(2 * t))
		new_pos.x = scale * cos(t)
		new_pos.y = scale * sin(2 * t) / 2
		
		points.append(new_pos * self.plot_scale)
		t += self.plot_step
		
func get_next_vector():
	var step1 = self.points[move_count]
	var next_move_count = self.move_count + 1
	if next_move_count >= self.points.size():
		self.move_count = 0
		next_move_count = 0
		print("cycle")
	var step2 = self.points[next_move_count]
	move_count += 1
	var result = step1 - step2
	
	return result # * Vector2(40, 25)
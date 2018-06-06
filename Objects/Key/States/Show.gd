extends Node

enum STATE { NULL, HIDE, SHOW, CARRY }

const UP = Vector2(0, -1)
const GRAVITY = 12
const FLOOR_FRICTION = 0.2

export var spawn_x_motion = 100
export var spawn_y_motion = 300

func enter(key):
	print(key.name + " SHOW")
	
	# Adjust key spawn y position to avoid
	# hitting player instantly
	var adjusted_pos = Vector2(key.spawn_position.x, key.spawn_position.y + -75)
	key.position = adjusted_pos
	# Adjust horizontal motion based on player facing
	var player = get_tree().get_root().get_node("World/Player")
	var player_sprite = player.get_node("Position2D/Sprite")
	# False is facing to the right
	if player_sprite.flip_h == false:
		key.motion.x = spawn_x_motion
	else:
		key.motion.x = -spawn_x_motion
	# Throw key up
	key.motion.y = -spawn_y_motion
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
	
	#Apply floor friction
	if key.is_on_floor():
		key.motion.x = lerp(key.motion.x, 0, FLOOR_FRICTION)
			
	# Process movement using Godot physics system
	key.motion = key.move_and_slide(key.motion, UP)
	pass
	
func handleInput(key, event):
	pass
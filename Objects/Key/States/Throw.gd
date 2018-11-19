extends Node

enum STATE { NULL, HIDE, SHOW, CARRY, THROW }

const UP = Vector2(0, -1)
const GRAVITY = 12
const FLOOR_FRICTION = 0.2

export var carry_offset = Vector2(0, -50)
export var throw_x_motion = 300
export var throw_y_motion = 100

var time_start = 0

func enter(key):
	print(key.name + " THROW")
	key.character.has_key = false
	var col = key.get_node("CollisionShape2D")
	col.disabled = false
	
	
	
	var player = get_tree().get_root().get_node("World/Player")
	var player_sprite = player.get_node("Position2D/Sprite")
	
	# Adjust key spawn y position to avoid
	# hitting player instantly
	#var adjusted_pos = Vector2(player.position.x, player.position.y + -175)
	#key.position = adjusted_pos
	time_start = OS.get_unix_time()
	
	# False is facing to the right
	if player_sprite.flip_h == false:
		key.motion.x = throw_x_motion + player.motion.x
		key.flip_sprite(false)
	else:
		key.motion.x = -(throw_x_motion - player.motion.x)
		key.flip_sprite(true)
	# Throw key up
	key.motion.y = -throw_y_motion
	
	pass

func exit(key):
	pass
	
func update(key, delta):
	#Gravity
	key.motion.y += GRAVITY
	
	# Poll Area2D for Character collision
	var elapsed = OS.get_unix_time() - time_start
	if elapsed > 0.5:
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
	
	pass
	
func handleInput(key, event):
	pass

extends "res://Character.gd"

const ACCELERATION = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = 300
const FLOOR_FRICTION = 0.2
	
func _physics_process(delta):
	var friction = false
	
	# Controls
	if Input.is_action_pressed("move_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Position2D/Sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Position2D/Sprite.flip_h = true
	else:
		friction = true
	
	if friction:
		motion.x = lerp(motion.x, 0, FLOOR_FRICTION)
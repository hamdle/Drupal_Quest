extends "res://Character.gd"

const ACCELERATION = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = 300
const FLOOR_FRICTION = 0.2
const AIR_FRICTION = 0.1
	
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
	
	# Apply air friction if player is in the air and
	# lets go of the move key
	if not is_on_floor() and \
	not Input.is_action_pressed("move_right") and \
	not Input.is_action_pressed("move_left"):
			motion.x = lerp(motion.x, 0, AIR_FRICTION)
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_HEIGHT
		# Apply friction on floor
		if friction:
			motion.x = lerp(motion.x, 0, FLOOR_FRICTION)
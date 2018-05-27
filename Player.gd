extends "res://Character.gd"

	
func _physics_process(delta):
	# Controls
	if Input.is_action_pressed("move_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Position2D/Sprite.flip_h = false
	if Input.is_action_pressed("move_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Position2D/Sprite.flip_h = true
		
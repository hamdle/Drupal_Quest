extends KinematicBody2D


# Physics and Jump
const UP = Vector2(0, -1)
const GRAVITY = 10
const ACCELERATION = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = 300

var motion = Vector2()

func _physics_process(delta):
	#Gravity
	motion.y += GRAVITY
	
	motion = move_and_slide(motion, UP)
extends KinematicBody2D


# Physics and Jump
const UP = Vector2(0, -1)
const GRAVITY = 12

var motion = Vector2()

func _physics_process(delta):
	#Gravity
	motion.y += GRAVITY
	
	# Process movement using Godot physics system
	motion = move_and_slide(motion, UP)
extends Node

enum STATE { NULL, IDLE, WALK, JUMP, HIT }

const UP = Vector2(0, -1)
const GRAVITY = 12
const ACCELERATION = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = 300
const FLOOR_FRICTION = 0.2
const AIR_FRICTION = 0.1

func enter(player):
	print("HIT")
	pass

func exit():
	pass
	
func update(player, delta):
	pass
	
func handleInput(event):
	pass

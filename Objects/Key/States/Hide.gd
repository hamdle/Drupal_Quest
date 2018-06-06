extends Node

enum STATE { NULL, WAIT, CARRY, HIDE }

const UP = Vector2(0, -1)
const GRAVITY = 0

func enter(key):
	print(key.name + " HIDE")
	pass

func exit(key):
	pass
	
func update(key, delta):
	pass
	
func handleInput(key, event):
	pass

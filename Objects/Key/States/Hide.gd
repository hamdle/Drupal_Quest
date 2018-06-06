extends Node

enum STATE { NULL, HIDE, SHOW, CARRY }

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

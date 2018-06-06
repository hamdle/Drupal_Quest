extends Node

<<<<<<< HEAD
enum STATE { NULL, HIDE, SHOW, CARRY }
=======
enum STATE { NULL, WAIT, CARRY, HIDE }
>>>>>>> a036f59806de7a7d0d6b6a73c64af1662dd0ebd0

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

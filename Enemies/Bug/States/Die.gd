extends Node

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }

const UP = Vector2(0, -1)
const GRAVITY = 12

export var carry_offset = Vector2(0, -50)

func enter(bug):
	print(bug.name + " DIE")
	bug.die()
	pass

func exit(bug):
	pass
	
func update(bug, delta):
	pass
	
func handleInput(bug, event):
	pass

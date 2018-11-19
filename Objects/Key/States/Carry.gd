extends Node

enum STATE { NULL, HIDE, SHOW, CARRY, THROW }

const UP = Vector2(0, -1)
const GRAVITY = 12

export var carry_offset = Vector2(0, -50)

func enter(key):
	print(key.name + " CARRY")
	key.character.has_key = true
	var col = key.get_node("CollisionShape2D")
	col.disabled = true
	
	pass

func exit(key):
	pass
	
func update(key, delta):
	key.position = key.character.position + carry_offset
	
	pass
	
func handleInput(key, event):
	pass

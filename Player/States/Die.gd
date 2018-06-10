extends Node

enum STATE { NULL, IDLE, WALK, JUMP, LAUNCH, WIN }

const MOUSE_RESET = Vector2(-1, -1)
const UP = Vector2(0, -1)
const GRAVITY = 12
const ACCELERATION = 20
const MAX_SPEED = 200
const FLOOR_FRICTION = 0.2
const AIR_FRICTION = 0.1

func enter(player):
	print(player.name + " DIE")
	# get_tree().reload_current_scene()
	var menus = get_tree().get_root().get_node("World/Menus")
	menus.player_died()

func exit(player):
	pass
	
func update(player, delta):
	pass
	
func handleInput(player, event):
	pass

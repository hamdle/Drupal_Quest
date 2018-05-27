extends Node

func enter():
	print("walk state")
	pass

func exit():
	print("walk exit")
	pass
	
func update(delta):
	pass
	
func handleInput(event):
	if Input.is_action_pressed("move_right"):
		return get_node("/root/Level/Player/States/Idle")
	pass

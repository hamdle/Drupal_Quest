extends Node

func enter():
	print("idle state")
	pass

func exit():
	print("idle exit")
	pass
	
func update(delta):
	pass
	
func handleInput(event):
	if Input.is_action_pressed("move_right"):
		return get_node("/root/Level/Player/States/Walk")
	pass

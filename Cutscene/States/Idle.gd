extends Node

enum STATE { NULL, IDLE }

func enter(processor):
	print(processor.name + " IDLE")

	pass

func exit(processor):
	pass
	
func update(processor, delta):
	pass
	
func handleInput(processor, event):
	pass

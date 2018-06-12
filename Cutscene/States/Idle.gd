extends Node

enum STATE { NULL, IDLE, SHOW_TEXT, WAIT }

func enter(processor):
	print(processor.name + " IDLE")

func exit(processor):
	pass
	
func update(processor, delta):
	return processor.process_next_index()
	
func handleInput(processor, event):
	pass
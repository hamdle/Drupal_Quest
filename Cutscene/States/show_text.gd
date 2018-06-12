extends Node

enum STATE { NULL, IDLE, SHOW_TEXT, WAIT }

var output_text

func enter(processor):
	print(processor.name + " show_text")

	pass

func exit(processor):
	pass
	
func update(processor, delta):
	return processor.process_next_index()
	pass
	
func handleInput(processor, event):
	pass

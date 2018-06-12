extends Node

enum STATE { NULL, IDLE, SHOW_TEXT, WAIT }

var timer_done = false

func enter(processor):
	print(processor.name + " wait")

	var timer = processor.get_node("Timer")
	timer.start()
	pass

func exit(processor):
	pass
	
func update(processor, delta):
	if timer_done:
		return processor.process_next_index()
	pass
	
func handleInput(processor, event):
	pass


func _on_Timer_timeout():
	timer_done = true

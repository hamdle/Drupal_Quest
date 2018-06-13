extends KinematicBody2D

var cutscene_array = []
var processing
var get_next = true

func _ready():
	pass
	
func _process(delta):
	if cutscene_array.empty():
		return
	
	if get_next:
		process_next_state()
	
	if processing == "show_text":
		$show_text.run(self)
	elif processing == "wait":
		$wait.run(self)
	
func _input(event):
	pass

func process_next_state():
	get_next = false
	if cutscene_array.empty():
		return
		
	var next_item = cutscene_array.pop_front()
	if next_item[0] == "show_text":
		print("show_text")
		processing = "show_text"
		$show_text.start(next_item[1])
		get_next = true
	elif next_item[0] == "wait":
		print("wait")
		processing = "wait"
		$wait.start(next_item[1])

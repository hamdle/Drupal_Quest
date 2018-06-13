extends Node

var text_to_type
var type_speed
var index

var complete = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func start(arg1, arg2):
	text_to_type = arg1
	type_speed = arg2
	$Timer.wait_time = float(type_speed)
	print($Timer.wait_time)
	$Timer.start()
	index = 0
	complete = false
	pass

func run(processor):
	if complete == true:
		$Timer.stop()
		processor.get_next = true
	pass

func type_next_letter():
	index += 1
	if index <= text_to_type.length():
		$Container/Label.text = text_to_type.substr(0, index)
	else:
		complete = true

func _on_Timer_timeout():
	type_next_letter()

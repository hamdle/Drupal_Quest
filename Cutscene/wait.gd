extends Node

var complete = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func start(arg):
	$Timer.wait_time = float(arg)
	$Timer.start()

func run(processor):
	if complete:
		$Timer.stop()
		complete = false
		processor.get_next = true

func _on_Timer_timeout():
	complete = true

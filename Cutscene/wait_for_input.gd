extends Node

var complete = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func start(arg):
	complete = false
	pass

func run(processor):
	if complete == true:
		processor.get_next = true

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_released("mouse_button"):
			complete = true
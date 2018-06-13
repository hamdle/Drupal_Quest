extends Node

var text_to_type
var type_speed

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func start(arg1, arg2):
	text_to_type = arg1
	type_speed = arg2
	pass

func run(processor):
	$Container/Label.text = text_to_type
	processor.get_next = true
	pass

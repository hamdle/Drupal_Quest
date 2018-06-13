extends Node

var text_to_show

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func start(arg):
	text_to_show = arg

func run(processor):
	$Container/Label.text = text_to_show
	processor.get_next = true
	
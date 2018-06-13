extends Node

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func start(arg):
	var clip = load(arg)
	$AudioStreamPlayer2D.stream = clip
	$AudioStreamPlayer2D.play()
	pass

func run(processor):
	pass

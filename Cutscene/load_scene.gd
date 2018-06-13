extends Node


func _ready():
	pass

func start(arg1):
	print("loading scene " + arg1)
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map[arg1])
	pass

func run(processor):
	pass

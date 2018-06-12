extends Node

var cutscene = [
	[ "show_text", "A long time ago" ],
	[ "wait", 2 ],
	[ "show_text", "A developer went to" ],
	[ "wait", 2 ],
]

func _ready():
	var cutscene_processor = get_node("CutsceneProcessor")
	cutscene_processor.cutscene_array = cutscene
	print(cutscene_processor.cutscene_array)
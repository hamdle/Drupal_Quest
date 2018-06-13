extends Node

var cutscene = [
	[ "show_text", "A long time ago" ],
	[ "wait", 2 ],
	[ "show_text", "A developer went to" ],
	[ "wait", 2 ],
	[ "play_audio", "res://Cutscene/sample.wav" ],
	[ "type_text", "drush", 0.5 ],
	[ "delete_text", "drush", 0.1 ],
	[ "type_text", "composer", 0.5 ],
	[ "play_audio", "res://Cutscene/sample.wav" ],
	[ "wait", 3 ],
	[ "load_scene", "story1" ],
]

func _ready():
	var cutscene_processor = get_node("CutsceneProcessor")
	cutscene_processor.cutscene_array = cutscene
	print(cutscene_processor.cutscene_array)
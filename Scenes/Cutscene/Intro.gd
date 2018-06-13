extends Node

var cutscene = [
	[ "show_text", "A long time ago" ],
	[ "wait", 2 ],
	[ "show_text", "a developer went to" ],
	[ "wait", 2 ],
	[ "show_text", "update core." ],
	[ "wait", 2 ],
	[ "play_audio", "res://Cutscene/sample.wav" ],
	[ "type_text", "drush", 0.1 ],
	[ "wait", 0.5 ],
	[ "delete_text", "drush", 0.05 ],
	[ "wait", 1 ],
	[ "play_audio", "res://Cutscene/sample.wav" ],
	[ "type_text", "composer update", 0.15 ],
	[ "wait", 1 ],
	[ "play_audio", "res://Cutscene/sample.wav" ],
	[ "type_text", "drupal/core", 0.1 ],
	[ "wait", 1 ],
	[ "play_audio", "res://Cutscene/sample.wav" ],
	[ "type_text", "--with-dependency", 0.1 ],
	[ "wait", 1 ],
	[ "show_text", "But somehow" ],
	[ "wait", 2 ],
	[ "show_text", "everything got updated" ],
	[ "wait", 2 ],
	[ "show_text", "EXCEPT for core." ],
	[ "wait", 2 ],
	[ "show_text", "This is where" ],
	[ "wait", 2 ],
	[ "show_text", "our story begins." ],
	[ "wait", 2 ],
	[ "show_text", "Like all modern web projects" ],
	[ "wait", 2 ],
	[ "show_text", "with a dependency issue." ],
	[ "wait", 1 ],
	[ "play_audio", "res://Cutscene/sample.wav" ],
	[ "type_text", "drupal quest begin", 0.1 ],
	[ "wait", 1.5 ],
	[ "load_scene", "story1" ],
]

func _ready():
	var cutscene_processor = get_node("CutsceneProcessor")
	cutscene_processor.cutscene_array = cutscene
	print(cutscene_processor.cutscene_array)
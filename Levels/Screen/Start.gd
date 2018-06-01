extends Node


func _on_StoryButton_pressed():
	var global = get_node("/root/global")
	global.story_mode()
	global.load_scene(global.LEVEL.CHARACTER)


func _on_ArcadeButton_pressed():
	var global = get_node("/root/global")
	global.arcade_mode()
	global.load_scene(global.LEVEL.CHARACTER)

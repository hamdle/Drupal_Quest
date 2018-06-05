extends Node


func _on_StoryButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.story_mode()
	gs.load_scene(gs.LEVEL.CHARACTER)


func _on_ArcadeButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.arcade_mode()
	gs.load_scene(gs.LEVEL.CHARACTER)
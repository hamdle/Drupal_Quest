extends Node


func _on_Level1Button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map["arcade1"])


func _on_Level2Button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map["arcade2"])


func _on_Level3Button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map["arcade3"])


func _on_BackButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map["start"])

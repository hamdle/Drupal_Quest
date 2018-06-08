extends Node


func _on_Level1Button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.LEVEL.ACRADE1)


func _on_Level2Button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.LEVEL.ARCADE2)


func _on_Level3Button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.LEVEL.ARCADE3)

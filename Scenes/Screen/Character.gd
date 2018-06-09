extends Node


func _on_DrupliconButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.select_character(gs.CHARACTER.DRUPLICON)
	load_scene_by_mode(gs)
	


func _on_Drupal8Button_pressed():
	var gs = get_node("/root/gamestate")
	gs.select_character(gs.CHARACTER.DRUPAL8)
	load_scene_by_mode(gs)

func _on_MagenticonButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.select_character(gs.CHARACTER.DRUPALQUEST)
	load_scene_by_mode(gs)

func load_scene_by_mode(gs):
	if gs.current_mode == gs.MODE.ARCADE:
		gs.load_scene(gs.level_map["arcade"])
	elif gs.current_mode == gs.MODE.STORY:
		gs.load_scene(gs.level_map["story1"])
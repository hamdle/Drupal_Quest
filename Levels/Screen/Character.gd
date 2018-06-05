extends Node


func _on_DrupliconButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.select_character(gs.CHARACTER.DRUPLICON)
	gs.load_scene(gs.LEVEL.AUTO)


func _on_Drupal8Button_pressed():
	var gs = get_node("/root/gamestate")
	gs.select_character(gs.CHARACTER.DRUPAL8)
	gs.load_scene(gs.LEVEL.AUTO)

func _on_MagenticonButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.select_character(gs.CHARACTER.DRUPALQUEST)
	gs.load_scene(gs.LEVEL.AUTO)

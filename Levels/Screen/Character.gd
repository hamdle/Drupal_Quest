extends Node


func _on_DrupliconButton_pressed():
	var global = get_node("/root/global")
	global.select_character(global.CHARACTER.DRUPLICON)
	global.load_scene(global.LEVEL.AUTO)


func _on_Drupal8Button_pressed():
	var global = get_node("/root/global")
	global.select_character(global.CHARACTER.DRUPAL8)
	global.load_scene(global.LEVEL.AUTO)


func _on_MagentaButton2_pressed():
	var global = get_node("/root/global")
	global.select_character(global.CHARACTER.MAGENTA)
	global.load_scene(global.LEVEL.AUTO)

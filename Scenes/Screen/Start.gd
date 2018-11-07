extends Node


func _on_ArcadeButton2_pressed():
	var gs = get_node("/root/gamestate")
	gs.arcade_mode()
	gs.load_scene("character")

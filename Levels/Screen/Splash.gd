extends Node


func _on_Timer_timeout():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.LEVEL.START)

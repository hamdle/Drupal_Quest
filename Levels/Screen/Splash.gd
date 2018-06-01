extends Node


func _on_Timer_timeout():
	var global = get_node("/root/global")
	global.load_scene(global.LEVEL.START)

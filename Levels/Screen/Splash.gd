extends Node


func _on_Timer_timeout():
	get_node("/root/global").load_scene("res://Levels/Screen/Start.tscn")
	pass # replace with function body

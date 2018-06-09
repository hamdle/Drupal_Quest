extends Node

var start_time
var end_time

func _ready():
	start_time = OS.get_unix_time()

func level_over():
	end_time = OS.get_unix_time()
	var elapsed_time = end_time - start_time

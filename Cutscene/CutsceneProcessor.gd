extends KinematicBody2D

var cutscene_array = []
var processing
var get_next = true

func _ready():
	pass
	
func _process(delta):
	if cutscene_array.empty():
		return
	
	if get_next:
		process_next_state()
	
	if processing == "show_text":
		$show_text.run(self)
	elif processing == "wait":
		$wait.run(self)
	elif processing == "play_audio":
		$play_audio.run(self)
	elif processing == "type_text":
		$type_text.run(self)
	elif processing == "delete_text":
		$delete_text.run(self)
	elif processing == "load_scene":
		$load_scene.run(self)
	
func _input(event):
	pass

func process_next_state():
	get_next = false
	if cutscene_array.empty():
		return
		
	var next_item = cutscene_array.pop_front()
	if next_item[0] == "show_text":
		print("show_text")
		$show_text/Container.visible = true
		$type_text/Container.visible = false
		$delete_text/Container.visible = false
		processing = "show_text"
		$show_text.start(next_item[1])
		get_next = true
	elif next_item[0] == "wait":
		print("wait")
		processing = "wait"
		$wait.start(next_item[1])
	elif next_item[0] == "play_audio":
		print("play_audio")
		processing = "play_audio"
		$play_audio.start(next_item[1])
		get_next = true
	elif next_item[0] == "type_text":
		print("type_text")
		$show_text/Container.visible = false
		$type_text/Container.visible = true
		$delete_text/Container.visible = false
		processing = "type_text"
		$type_text.start(next_item[1], next_item[2])
	elif next_item[0] == "delete_text":
		print("delete_text")
		$show_text/Container.visible = false
		$type_text/Container.visible = false
		$delete_text/Container.visible = true
		processing = "delete_text"
		$delete_text.start(next_item[1], next_item[2], $type_text)
	elif next_item[0] == "load_scene":
		print("load_scene")
		processing = "load_scene"
		$load_scene.start(next_item[1])

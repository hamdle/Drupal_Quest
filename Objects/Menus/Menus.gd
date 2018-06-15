extends Node

var start_time
var pause_time
var paused = false
var showing_menu = false

export var current_level = "none"
export var next_level = "none"

func _ready():
	start_time = OS.get_ticks_msec()
	
	$DieMenu.visible = false
	$WinMenu.visible = false
	$PauseMenu.visible = false

func _input(event):
	# Escape to Start screen shortcut
	if not showing_menu:
		if Input.is_action_just_pressed("escape"):
			_level_pause()

func player_died():
	$DieMenu.visible = true
	_level_over($DieMenu)
	
func player_win():
	$WinMenu.visible = true
	
	# Set finish time
	var gs = get_node("/root/gamestate")
	var finish_time = (OS.get_ticks_msec() - start_time) / 1000.0
	var time_label = $WinMenu/CC/VBC/MC3/TimeLabel
	time_label.text = String(finish_time) \
	+ " J" + String(gs.local_jumps) \
	+ " L" + String(gs.local_launches) \
	+ " M" + String(gs.local_moves)
	_level_over($WinMenu)

func _level_pause():
	paused = not paused
	
	if paused == false:
		print(start_time)
		print(pause_time)
		print(OS.get_ticks_msec() - pause_time)
		start_time = start_time + (OS.get_ticks_msec() - pause_time)
	
	pause_time = OS.get_ticks_msec()
	
	# Show current time
	var current_time = (pause_time - start_time) / 1000.0
	var time_label = $PauseMenu/CC/VBC/MC3/TimeLabel
	time_label.text = String(current_time)
	# Set menu location
	var player = get_tree().get_root().get_node("World/Player")
	var new_loc = Vector2()
	new_loc.x = player.position.x
	new_loc.y = player.position.y - 50
	$PauseMenu.position = new_loc
	
	$PauseMenu.visible = paused
	get_tree().paused = paused
	
	

func _level_over(menu):
	
	get_tree().paused = true
	
	showing_menu = true
	
	# Set menu location
	var player = get_tree().get_root().get_node("World/Player")
	var new_loc = Vector2()
	new_loc.x = player.position.x
	new_loc.y = player.position.y - 50
	menu.position = new_loc


func _on_PlayAgainButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map[current_level])


func _on_NextLevelButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map[next_level])


func _on_QuitButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map["start"])

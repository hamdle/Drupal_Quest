extends Node

var start_time

export var current_level = "none"
export var next_level = "none"

func _ready():
	start_time = OS.get_ticks_msec()
	
	$DieMenu.visible = false
	$WinMenu.visible = false
	$PauseMenu.visible = false

func _input(event):
	# Escape to Start screen shortcut
	if Input.is_action_just_pressed("escape"):
		level_pause()

func player_died():
	$DieMenu.visible = true
	_level_over($DieMenu)
	
func player_win():
	$WinMenu.visible = true
	# Set finish time
	var finish_time = (OS.get_ticks_msec() - start_time) / 1000.0
	var time_label = $WinMenu/CC/VBC/MC3/TimeLabel
	time_label.text = String(finish_time)
	_level_over($WinMenu)

func level_pause():
	$PauseMenu.visible = true

func _level_over(menu):
	
	get_tree().paused = true
	
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

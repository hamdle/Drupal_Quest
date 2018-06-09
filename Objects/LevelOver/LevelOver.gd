extends Node

var start_time

export var current_level = "none"
export var next_level = "none"

func _ready():
	start_time = OS.get_ticks_msec()
	
	$KinematicBody2D.visible = false

func level_over_die():
	# Set title label
	var title_label = $KinematicBody2D/CenterContainer/VBoxContainer/MarginContainer2/TitleLabel
	title_label.text = "You Died"
	
	# Clear time label
	var time_label = $KinematicBody2D/CenterContainer/VBoxContainer/MarginContainer3/TimeLabel
	time_label.visible = false
	
	level_over()
	
func level_over_win():
	# Set title label
	var title_label = $KinematicBody2D/CenterContainer/VBoxContainer/MarginContainer2/TitleLabel
	title_label.text = "Complete!!"
	
	# Set time label
	var elapsed_time = OS.get_ticks_msec() - start_time
	var time_label = $KinematicBody2D/CenterContainer/VBoxContainer/MarginContainer3/TimeLabel
	time_label.text = String(elapsed_time / 1000.0)
	
	level_over()
	
func level_over():
	# Show the level over menu
	$KinematicBody2D.visible = true
	
	
	get_tree().paused = true
	
	# Set menu location
	var player = get_tree().get_root().get_node("World/Player")
	var new_loc = Vector2()
	new_loc.x = player.position.x
	new_loc.y = player.position.y - 50
	$KinematicBody2D.position = new_loc


func _on_PlayAgainButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map[current_level])


func _on_NextLevelButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map[next_level])

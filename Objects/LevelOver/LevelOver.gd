extends Node

var start_time
var end_time

var level_map = {
	"none": null,
	"splash": "res://Scenes/Screen/Splash.tscn",
	"start": "res://Scenes/Screen/Start.tscn",
	"character": "res://Scenes/Screen/Character.tscn",
	"story1": "res://Scenes/Story/Story1.tscn",
	"arcade": "res://Scenes/Screen/Arcade.tscn",
	"arcade1": "res://Scenes/Arcade/Arcade1.tscn",
	"arcade2": "res://Scenes/Arcade/Arcade2.tscn",
	"arcade3": "res://Scenes/Arcade/Arcade3.tscn"	
}

export var current_level = "none"
export var next_level = "none"

func _ready():
	start_time = OS.get_unix_time()
	
	$Container.visible = false

func level_over():
	end_time = OS.get_unix_time()
	var elapsed_time = end_time - start_time
	
	# Show the level over menu
	$Container.visible = true
	
	# Set the elapsed time
	var time_label = $Container/CenterContainer/VBoxContainer/MarginContainer3/TimeLabel
	time_label.text = String(elapsed_time)
	
	get_tree().paused = true
	#var gs = get_node("/root/gamestate")
	#gs.load_scene(gs.LEVEL.AUTO)


func _on_PlayAgainButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(level_map[current_level])

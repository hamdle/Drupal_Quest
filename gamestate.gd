extends Node

enum MODE { ARCADE }
enum CHARACTER { CLASSIC, DRUPAL8, JUMPAL }

var level_map = {
	"none": null,
	"start": "res://Scenes/Screen/Start.tscn",
	"character": "res://Scenes/Screen/Character.tscn",
	"levelselect": "res://Scenes/Screen/Arcade.tscn",
	
	"level1": "res://Scenes/Arcade/Level1.tscn",
	"level2": "res://Scenes/Arcade/Arcade2.tscn",
	"level3": "res://Scenes/Arcade/Arcade3.tscn",
	"level4": "res://Scenes/Arcade/Arcade4.tscn",
	"level5": "res://Scenes/Arcade/Arcade5.tscn",
	"level6": "res://Scenes/Arcade/Arcade6.tscn",
	
	"level7": "res://Scenes/Arcade/Arcade7.tscn",
	"level8": "res://Scenes/Arcade/Arcade8.tscn",
	"level9": "res://Scenes/Arcade/Arcade9.tscn",
	"level10": "res://Scenes/Arcade/Arcade10.tscn",
	"level11": "res://Scenes/Arcade/Arcade11.tscn",
	"level12": "res://Scenes/Arcade/Arcade12.tscn",
	
	"level13": "res://Scenes/Arcade/Arcade13.tscn",
	"level14": "res://Scenes/Arcade/Arcade14.tscn",
	"level15": "res://Scenes/Arcade/Arcade15.tscn",
	"level16": "res://Scenes/Arcade/Arcade16.tscn",
	"level17": "res://Scenes/Arcade/Arcade17.tscn",
	"level18": "res://Scenes/Arcade/Arcade18.tscn",
}

var level_data = {
	"level1": "3-00:20:12",
	"level2": "1-00:42:48",
	"level3": "3-00:24:44",
	"level4": "2-01:09:32",
	"level5": "3-01:09:32",
	"level6": "2-01:09:32",
	
	"level7": "1-01:09:32",
	"level8": "1-01:09:32",
	"level9": "3-01:09:32",
	"level10": "2-01:09:32",
	"level11": "4-0",
	"level12": "0-0",
	
	"level13": "0-0",
	"level14": "0-0",
	"level15": "0-0",
	"level16": "0-0",
	"level17": "0-0",
	"level18": "0-0",
}

var current_scene_instance = null
var current_mode = null
var current_character = null

# Stat variables
var local_jumps = 0
var local_launches = 0
var local_moves = 0

func _ready():
	# Get main scene
	var root = get_tree().get_root()
	current_scene_instance = root.get_child(root.get_child_count() - 1)
	# Bypass project settings > main scene
	# load_scene("arcade")
	
	# Default mode
	arcade_mode()
	# Default Druplicon character
	select_character(CHARACTER.CLASSIC)

# Scene loading
func load_scene(res):
	call_deferred("_deferred_load_scene", res)

func _deferred_load_scene(res):
	# Immediately release current scene
	current_scene_instance.free()
	
	# Reset level stats
	local_jumps = 0
	local_launches = 0
	local_moves = 0
	
	# Load level resource
	var s = ResourceLoader.load(res)
	# And create an instance
	current_scene_instance = s.instance()
	# Add instance to node tree
	get_tree().get_root().add_child(current_scene_instance)
	# SceneTree.change_scene() API compatibility
	get_tree().set_current_scene(current_scene_instance)
	# Make sure the node tree is not paused
	get_tree().paused = false

# Game mode
func arcade_mode():
	current_mode = MODE.ARCADE

# Character select
func select_character(character):
	current_character = character
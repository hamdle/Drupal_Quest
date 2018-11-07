extends Node

enum MODE { ARCADE }
enum CHARACTER { CLASSIC, DRUPAL8, JUMPAL }

var current_level_key = "none"
const number_of_levels = 18
var level_map = {
	"none": null,
	"start": "res://Scenes/Screen/Start.tscn",
	"character": "res://Scenes/Screen/Character.tscn",
	"levelselect": "res://Scenes/Screen/Arcade.tscn",
	
	"level1": "res://Scenes/Arcade/Level1.tscn",
	"level2": "res://Scenes/Arcade/Level2.tscn",
	"level3": "res://Scenes/Arcade/Level3.tscn",
	"level4": "res://Scenes/Arcade/Level4.tscn",
	"level5": "res://Scenes/Arcade/Level5.tscn",
	"level6": "res://Scenes/Arcade/Level6.tscn",
	
	"level7": "res://Scenes/Arcade/Level7.tscn",
	"level8": "res://Scenes/Arcade/Level8.tscn",
	"level9": "res://Scenes/Arcade/Level9.tscn",
	"level10": "res://Scenes/Arcade/Level10.tscn",
	"level11": "res://Scenes/Arcade/Level11.tscn",
	"level12": "res://Scenes/Arcade/Level12.tscn",
	
	"level13": "res://Scenes/Arcade/Level13.tscn",
	"level14": "res://Scenes/Arcade/Level14.tscn",
	"level15": "res://Scenes/Arcade/Level15.tscn",
	"level16": "res://Scenes/Arcade/Level16.tscn",
	"level17": "res://Scenes/Arcade/Level17.tscn",
	"level18": "res://Scenes/Arcade/Level18.tscn",
}

var level_data = {
	"level1": "4-0",
	"level2": "0-0",
	"level3": "0-0",
	"level4": "0-0",
	"level5": "0-0",
	"level6": "0-0",
	
	"level7": "0-0",
	"level8": "0-0",
	"level9": "0-0",
	"level10": "0-0",
	"level11": "0-0",
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
func load_next_scene():
	var i = current_level_key.to_int() + 1
	var key = "level" + str(i)
	
	if i > number_of_levels:
		load_scene("levelselect")
	else:
		load_scene(key)
	pass

func reload_scene():
	load_scene(current_level_key)
	pass
	
func load_scene(key):
	current_level_key = key
	var res = level_map[current_level_key]
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
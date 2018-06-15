extends Node

enum MODE { STORY, ARCADE }
enum CHARACTER { DRUPLICON, DRUPAL8, DRUPALQUEST }

var level_map = {
	"none": null,
	"splash": "res://Scenes/Screen/Splash.tscn",
	"start": "res://Scenes/Screen/Start.tscn",
	"character": "res://Scenes/Screen/Character.tscn",
	"intro": "res://Scenes/Cutscene/Intro.tscn",
	"story1": "res://Scenes/Story/Story1.tscn",
	"arcade": "res://Scenes/Screen/Arcade.tscn",
	"arcade1": "res://Scenes/Arcade/Arcade1.tscn",
	"arcade2": "res://Scenes/Arcade/Arcade2.tscn",
	"arcade3": "res://Scenes/Arcade/Arcade3.tscn"	
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
	
	# Default story mode
	story_mode()
	# Default Druplicon character
	select_character(CHARACTER.DRUPLICON)

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
	
func story_mode():
	current_mode = MODE.STORY

# Character select
func select_character(character):
	current_character = character
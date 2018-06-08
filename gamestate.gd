extends Node

enum LEVEL { 
	AUTO, 
	SPLASH, START, CHARACTER, 
	STORY1,
	ARCADE1, ARCADE2, ARCADE3
}
enum MODE { STORY, ARCADE }
enum CHARACTER { DRUPLICON, DRUPAL8, DRUPALQUEST }

var current_scene = null
var current_mode = null
var current_character = null
var current_level = null

var level_map = {
	LEVEL.AUTO: "auto",
	LEVEL.SPLASH: "res://Scenes/Screen/Splash.tscn",
	LEVEL.START: "res://Scenes/Screen/Start.tscn",
	LEVEL.CHARACTER: "res://Scenes/Screen/Character.tscn",
	LEVEL.ARCADE: "res://Scenes/Screen/Arcade.tscn",
	LEVEL.STORY1: "res://Scenes/Story/Story1.tscn",
	LEVEL.ARCADE1: "res://Scenes/Arcade/Arcade1.tscn",
	LEVEL.ARCADE2: "res://Scenes/Arcade/Arcade2.tscn",
	LEVEL.ARCADE3: "res://Scenes/Arcade/Arcade3.tscn"	
}

func _ready():
	# Get main scene
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	# Bypass project settings > main scene
	# load_scene(LEVEL.START)
	
	# Default story mode
	story_mode()
	# Default Druplicon character
	select_character(CHARACTER.DRUPLICON)

# Scene loading
func load_scene(level):
	call_deferred("_deferred_load_scene", level)
	
func _deferred_load_scene(level):
	# Immediately release current scene
	current_scene.free()
	
	# Load level resource
	var s = ResourceLoader.load(_get_level(level))
	# And create an instance
	current_scene = s.instance()
	# Add instance to node tree
	get_tree().get_root().add_child(current_scene)
	# SceneTree.change_scene() API compatibility
	get_tree().set_current_scene(current_scene)

func _get_level(level):
	if level == LEVEL.AUTO:
		if current_mode == MODE.ARCADE:
			return level_map[LEVEL.ARCADE]
		if current_mode == MODE.STORY:
			return level_map[LEVEL.STORY1]
			
	if level_map.has(level):
		return level_map[level]
		
	return level_map[LEVEL.START]

# Game mode
func arcade_mode():
	current_mode = MODE.ARCADE
	
func story_mode():
	current_mode = MODE.STORY

# Character select
func select_character(character):
	current_character = character
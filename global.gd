extends Node

enum LEVEL { 
	AUTO, 
	SPLASH, START, CHARACTER, 
	STORY_1,
	ARCADE_1, ARCADE_2, ARCADE_3
}
enum MODE { STORY, ARCADE }
enum CHARACTER { DRUPLICON, DRUPAL8, MAGENTA }

var current_scene = null
var current_mode = null
var current_character = null

func _ready():
	# Get main scene
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	# Default story mode
	story_mode()
	# Default Druplicon character
	select_character(CHARACTER.DRUPLICON)

# Scene loading
func load_scene(path):
	call_deferred("_deferred_load_scene", path)
	
func _deferred_load_scene(path):
	current_scene.free()
	
	var s = ResourceLoader.load(path)
	
	current_scene = s.instance()
	
	get_tree().get_root().add_child(current_scene)
	
	get_tree().set_current_scene(current_scene)

# Game mode
func arcade_mode():
	current_mode = MODE.ARCADE
	
func story_mode():
	current_mode = MODE.STORY

# Character select
func select_character(character):
	current_character = character
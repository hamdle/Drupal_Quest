extends Node

func _ready():
	# Get and set level data
	load_level_data()
	
	# Show character selected
	show_character()
	
	pass
	
func _process(delta):
	pass

func show_character():
	var gs = get_node("/root/gamestate")
	print(gs.current_character)
	var cur = gs.current_character
	if (cur == gs.CHARACTER.CLASSIC):
		$Container/CharacterDisplay.texture = $Container/CharacterDisplay.drupal_texture
	elif (cur == gs.CHARACTER.DRUPAL8):
		$Container/CharacterDisplay.texture = $Container/CharacterDisplay.drupal_8_texture
	elif (cur == gs.CHARACTER.JUMPAL):
		$Container/CharacterDisplay.texture = $Container/CharacterDisplay.drupal_quest_texture

func load_level_data():
	var level1 = get_node("Container/LevelGrid/Row/level1/level1button")
	var best_time = get_node("Container/LevelGrid/Row/level1/BestTime")
	
	var gs = get_node("/root/gamestate")
	for i in gs.level_data:
		var i_data = gs.level_data[i]
		var arr = i_data.split("-", i_data)
		
		# Calculate container row number
		var row = i.to_int()
		var row_str = ""
		if row > 6:
			row_str = "2"
		if row > 12:
			row_str = "3"
		
		# Create path strings
		var button_str = "Container/LevelGrid/Row" + row_str + "/" + i + "/" + i + "button"
		var time_str = "Container/LevelGrid/Row" + row_str + "/" + i + "/BestTime"
		var star1_str = "Container/LevelGrid/Row" + row_str + "/" + i + "/HBox/Star1"
		var star2_str = "Container/LevelGrid/Row" + row_str + "/" + i + "/HBox/Star2"
		var star3_str = "Container/LevelGrid/Row" + row_str + "/" + i + "/HBox/Star3"
		
		# Level is locked
		if (arr[0] == "0"):
			# Hide time
			var time_text = get_node(NodePath(time_str))
			time_text.text = ""
			# Hide stars
			var star1 = get_node(NodePath(star1_str))
			star1.visible = false
			var star2 = get_node(NodePath(star2_str))
			star2.visible = false
			var star3 = get_node(NodePath(star3_str))
			star3.visible = false
			# Disable button
			var button = get_node(NodePath(button_str))
			button.disabled = true
		# Level is unlocked
		else:
			# Show time
			var time_text = get_node(NodePath(time_str))
			time_text.text = arr[1]
			# Except for new, unplayed levels
			# Which are marked as 4
			if (arr[0] == "4"):
				time_text.text = ""
			# Show stars
			if (arr[0] == "1"):
				var star1 = get_node(NodePath(star1_str))
				star1.visible = true
				var star2 = get_node(NodePath(star2_str))
				star2.visible = false
				var star3 = get_node(NodePath(star3_str))
				star3.visible = false
			if (arr[0] == "2"):
				var star1 = get_node(NodePath(star1_str))
				star1.visible = true
				var star2 = get_node(NodePath(star2_str))
				star2.visible = true
				var star3 = get_node(NodePath(star3_str))
				star3.visible = false
			if (arr[0] == "3"):
				var star1 = get_node(NodePath(star1_str))
				star1.visible = true
				var star2 = get_node(NodePath(star2_str))
				star2.visible = true
				var star3 = get_node(NodePath(star3_str))
				star3.visible = true
			if (arr[0] == "4"):
				var star1 = get_node(NodePath(star1_str))
				star1.visible = false
				var star2 = get_node(NodePath(star2_str))
				star2.visible = false
				var star3 = get_node(NodePath(star3_str))
				star3.visible = false
			# Enable button
			var button = get_node(NodePath(button_str))
			button.disabled = false
			pass

# Signals

func _on_BackButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("character")

func _on_level1button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level1")
	
func _on_level2button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level2")

func _on_level3button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level3")


func _on_level4button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level4")


func _on_level5button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level5")


func _on_level6button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level6")


func _on_level7button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level7")


func _on_level8button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level8")


func _on_level9button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level9")


func _on_level10button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level10")


func _on_level11button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level11")


func _on_level12button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level12")


func _on_level13button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level13")


func _on_level14button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level14")


func _on_level15button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level15")


func _on_level16button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level16")


func _on_level17button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level17")


func _on_level18button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene("level18")

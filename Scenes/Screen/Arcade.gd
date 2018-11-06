extends Node

func _ready():
	var level1 = get_node("Container/LevelGrid/Row/level1/level1button")
	#level1.disabled = true
	#var star3 = get_node("Container/LevelGrid/Row/level1/HBox/Star3")
	#star3.visible = false
	var best_time = get_node("Container/LevelGrid/Row/level1/BestTime")
	#best_time.text = "1:24:02"
	
	var gs = get_node("/root/gamestate")
	for i in gs.level_data:
		var i_data = gs.level_data[i]
		print(i_data)
		var arr = i_data.split("-", i_data)
		print(arr)
		
		# Create path strings
		var button_str = "Container/LevelGrid/Row/" + i + "/" + i + "button"
		var time_str = "Container/LevelGrid/Row/" + i + "/BestTime"
		var star1_str = "Container/LevelGrid/Row/" + i + "/HBox/Star1"
		var star2_str = "Container/LevelGrid/Row/" + i + "/HBox/Star2"
		var star3_str = "Container/LevelGrid/Row/" + i + "/HBox/Star3"
		
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
			# Enable button
			var button = get_node(NodePath(button_str))
			button.disabled = false
			pass
	
	pass
	
func _process(delta):
	pass

# Signals

func _on_BackButton_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map["start"])

func _on_level2button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map["level2"])

func _on_level3button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map["level2"])

func _on_level1button_pressed():
	var gs = get_node("/root/gamestate")
	gs.load_scene(gs.level_map["level3"])

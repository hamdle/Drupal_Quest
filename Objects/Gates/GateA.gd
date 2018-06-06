extends KinematicBody2D

func _ready():
	pass

func _process(delta):
	# Poll Area2D for Character collision
	var area = $Area2D
	for body in area.get_overlapping_bodies():
		if body.name == "Player":
			teleport_player_to_gate_b()
		if ("TAG" in body): # If TAG exists
			if body.TAG == "Bug": # If the TAG is a Bug
				teleport_enemy_to_gate_a(body)
			elif body.TAG == "Flying": # If the TAG is a Bug
				teleport_enemy_to_gate_a(body)

func teleport_player_to_gate_b():
	# Get player
	var player = get_tree().get_root().get_node("World/Player")
	# Get Gates B position
	var gate_b = get_tree().get_root().get_node("World/Gates/GateB")
	# Set player to Gate B position
	var teleport_to_position = gate_b.position
	teleport_to_position.y += 50
	player.position = teleport_to_position
	player.motion = Vector2(0, 0)

func teleport_enemy_to_gate_a(body):
	var gate_a = get_tree().get_root().get_node("World/Gates/GateB")
	# Set player to Gate B position
	var teleport_to_position = gate_a.position
	teleport_to_position.y += 50
	body.position = teleport_to_position

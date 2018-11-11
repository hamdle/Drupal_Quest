extends KinematicBody2D

export var gate_player = true
export var gate_bug = true
export var gate_flying = true
export var gate_key = true
export var spawn_y_diff = 70

func _ready():
	pass

func _process(delta):
	# Poll Area2D for Character collision
	var area = $Area2D
	for body in area.get_overlapping_bodies():
		if ("TAG" in body): # If TAG exists
			if body.name == "Player" and gate_player == true:
				teleport_object_to_gate_b(body)
			elif body.TAG == "Bug" and gate_bug == true: # If the TAG is a Bug
				teleport_object_to_gate_b(body)
			elif body.TAG == "Flying" and gate_flying == true: # If the TAG is a Bug
				teleport_object_to_gate_b(body)
			elif body.TAG == "Key" and gate_key == true:
				teleport_object_to_gate_b(body)

func teleport_object_to_gate_b(body):
	var gate_a = get_tree().get_root().get_node("World/Gates/GateB")
	# Set player to Gate B position
	var teleport_to_position = gate_a.position
	teleport_to_position.y += spawn_y_diff
	body.position = teleport_to_position
	body.motion = Vector2(0, 0)
	print("gate " + body.name + " to b")
	print (body.position)

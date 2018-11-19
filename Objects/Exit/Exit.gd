extends KinematicBody2D

signal exit_entered

func _ready():
	var character = get_tree().get_root().get_node("World/Player")
	self.connect("exit_entered", character, "_on_Exit_entered", [])

func _process(delta):
	# Poll Area2D for Character collision
	var area = get_node("Area2D")
	for body in area.get_overlapping_bodies():
		if body.name == "Player":
			emit_signal("exit_entered", body.name)
		if body.name == "Key":
			emit_signal("exit_entered", body.name)

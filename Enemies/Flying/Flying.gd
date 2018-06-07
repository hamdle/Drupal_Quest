extends KinematicBody2D

signal player_damage
signal bug_damage
signal enemy_died

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }

const TAG = "Flying"

# Physics and Jump
var motion = Vector2()

# State Machine
var current_state

onready var state_nodes = {
	STATE.IDLE: $States/Idle,
	STATE.PATROL: $States/Patrol,
	STATE.ATTACK: $States/Attack,
	STATE.DIE: $States/Die
}

func _ready():
	# Set animation
	$AnimationPlayer.play("SETUP")
	
	# Setup player_damage signal
	var player = get_tree().get_root().get_node("World/Player")
	self.connect("player_damage", player, "_on_Player_damage", [])
	var bugs = get_tree().get_nodes_in_group("bug")
	for bug in bugs:
		self.connect("bug_damage", bug, "_on_Bug_damage")
	# Setup died signal to notify Key
	var key = get_tree().get_root().get_node("World/Key")
	self.connect("enemy_died", key, "_on_Enemy_die")
	
	# Add to 'flying' group
	self.add_to_group("flying")
	self.add_to_group("enemies")
	
	# Process state machine
	current_state = state_nodes[STATE.PATROL]
	current_state.enter(self)
	pass
	
func _physics_process(delta):
	# Process state machine
	var new_state = current_state.update(self, delta)
	if new_state:
		current_state.exit(self)
		current_state = state_nodes[new_state]
		current_state.enter(self)
	
func _input(event):
	# Process state machine
	var new_state = current_state.handleInput(self, event)
	if new_state:
		current_state.exit(self)
		current_state = state_nodes[new_state]
		current_state.enter(self)
	
func flip_sprite(flip):
	$Position2D/Sprite.flip_h = flip
	
func die():
	# Play dead animation
	$AnimationPlayer.play("DIE")
	
	# Remove from the living
	remove_from_group("enemies")
	var enemies = get_tree().get_nodes_in_group("enemies")
	print(enemies)
	
	$TakeDamageArea2D/CollisionShape2D.disabled = true
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	$Timer.start()
	
	emit_signal("enemy_died", self.position)

func emit_player_damage_signal():
	emit_signal("player_damage")
	
func emit_bug_damage_signal(name):
	emit_signal("bug_damage", name)

func _on_Timer_timeout():
	# Turn off collision
	# only if we've hit the ground since death
	if not current_state == state_nodes[STATE.DIE]:
		var col = get_node("CollisionShape2D")
		col.disabled = true
	
func _on_AnimationPlayer_animation_finished(anim_name):
	# This function runs when any character animation is finished
	# DOES NOT RUN if animation is set to loop
	pass
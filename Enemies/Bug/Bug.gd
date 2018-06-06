extends KinematicBody2D

signal player_damage
signal enemy_died

enum STATE { NULL, IDLE, PATROL, ATTACK, DIE }

const TAG = "Bug"

# Physics and Jump
var motion = Vector2()

# AI system
var patrol_origin = Vector2()

# State Machine
var current_state

onready var state_nodes = {
	STATE.IDLE: $States/Idle,
	STATE.PATROL: $States/Patrol,
	STATE.ATTACK: $States/Attack,
	STATE.DIE: $States/Die
}

func _ready():
	# Set base animation
	$AnimationPlayer.play("SETUP")
	
	# Setup player_damage signal
	var character = get_tree().get_root().get_node("World/Player")
	self.connect("player_damage", character, "_on_Player_damage", [])
	# Setup died signal to notify Key
	var key = get_tree().get_root().get_node("World/Key")
	self.connect("enemy_died", key, "_on_Enemy_die")
	
	# Add to appropriate groups
	self.add_to_group("bug")
	self.add_to_group("enemies")
	
	# Process state machine
	current_state = state_nodes[STATE.IDLE]
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

# Helper functions
func flip_sprite(flip):
	$Position2D/Sprite.flip_h = flip

func set_patrol_origin():
	patrol_origin = transform.origin
	
func die():
	# Play dead animation
	$AnimationPlayer.play("DIE")
	
	# Remove from the living
	remove_from_group("enemies")
	var enemies = get_tree().get_nodes_in_group("enemies")
	
	
	$TakeDamageArea2D/CollisionShape2D.disabled = true
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	$Timer.start()
	
	emit_signal("enemy_died", self.position)

# Signal functions
func emit_damage_signal():
	emit_signal("player_damage")

func _on_Timer_timeout():
	# Turn off collision
	var col = get_node("CollisionShape2D")
	col.disabled = true

func _on_Bug_damage(name):
	if self.name == name:
		current_state.exit(self)
		current_state = state_nodes[STATE.DIE]
		current_state.enter(self)
		
func _on_AnimationPlayer_animation_finished(anim_name):
	# This function runs when any character animation is finished
	# DOES NOT RUN if animation is set to loop
	pass
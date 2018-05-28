extends "../Character.gd"

# Physics and Jump
var motion = Vector2()

# State Machine
var current_state
enum STATE { NULL, IDLE, WALK, JUMP, HIT }

onready var state_nodes = {
	STATE.IDLE: $States/Idle,
	STATE.WALK: $States/Walk,
	STATE.JUMP: $States/Jump,
	STATE.HIT: $States/Hit
}

func _ready():
	# Set animation
	$AnimationPlayer.play("FLOAT")
	
	# Process state machine
	current_state = state_nodes[STATE.IDLE]
	current_state.enter(self)
	pass
	
func _physics_process(delta):
	# Process state machine
	var new_state = current_state.update(self, delta)
	if new_state:
		current_state.exit()
		current_state = state_nodes[new_state]
		current_state.enter(self)
	
func _input(event):
	# Debug
	if Input.is_action_just_pressed("fire"):
		$AnimationPlayer.play("HIT")
		current_state.exit()
		current_state = state_nodes[STATE.HIT]
		current_state.enter(self)
	
	# Process state machine
	var new_state = current_state.handleInput(event)
	if new_state:
		current_state.exit()
		current_state = state_nodes[new_state]
		current_state.enter(self)
	
func flip_sprite(flip):
	$Position2D/Sprite.flip_h = flip
	
func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("FLOAT")
	current_state.exit()
	current_state = state_nodes[STATE.IDLE]
	current_state.enter(self)
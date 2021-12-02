extends KinematicBody2D

enum states {CHASE, CONFUZED}

var anim = "idle"
var vel = 25
var state
var character

func _ready():
	add_to_group("monster")
	get_node("AnimationPlayer").play(anim)
	state = states.CHASE

func _process(delta):
	if (state == states.CHASE):
		state_chase(delta)
	
	if (state == states.CONFUZED):
		state_confuzed(delta)

func state_confuzed(delta):
	var dirX = rand_range(-1,1)
	var dirY = rand_range(-1, 1)
	
	var motion = Vector2(dirX,dirY)
	motion = motion.normalized()
	move_and_collide(motion * vel * delta)

func state_chase(delta):
	if character == null:
		return
		
	var vect_to_character = character.global_position - global_position
	vect_to_character = vect_to_character.normalized()
	move_and_collide(vect_to_character * vel * delta)

func set_character(player):
	print_debug(player)
	character = player

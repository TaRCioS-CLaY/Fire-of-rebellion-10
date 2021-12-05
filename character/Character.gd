extends KinematicBody2D

var vel = 50
var push_speed = 125.0
onready var sprite = get_node( "Sprite" )
onready var torch_light = get_node("Light2D_torch")
onready var torch_light_ambient = get_node("Light2D_torch_ambient")
onready var shadow = get_node("LightOccluder2D_shadow")
var anim = "idle_torch"
var motion = Vector2(0, 0)
var old_motion = Vector2(0, 0)
var screen_size
var dirX = 0
var dirY = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	get_node("AnimationPlayer").play(anim)
	yield(get_tree(), "idle_frame")
	get_tree().call_group("monster", "set_character", self)

func _physics_process(delta: float) -> void:
	move_and_collide(Vector2(dirX, dirY) * delta)
	if $pushRight.is_colliding():
		var minecart = $pushRight.get_collider()
		print(minecart as Minecart_side)
		if minecart as Minecart_side:
			minecart.move(40,0, push_speed , delta)
	elif $pushLeft.is_colliding():
		var minecart = $pushLeft.get_collider()
		if minecart as Minecart_side:
			minecart.move(-40,0, push_speed , delta)
	elif $pushUp.is_colliding():
		var minecart = $pushUp.get_collider()
		if minecart as Minecart_top:
			minecart.move(0,-40, push_speed, delta)
	elif $pushDown.is_colliding():
		var minecart = $pushDown.get_collider()
		if minecart as Minecart_top:
			minecart.move(0,40, push_speed, delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dirX = 0
	dirY = 0
	
	if Input.is_action_pressed("ui_left"):
		dirX += -2
		sprite.set_flip_h(true)
		torch_light.position.x = -8
		torch_light_ambient.position.x = -8
		shadow.scale.x = -1
		anim = "walk_torch"
		
	if Input.is_action_pressed("ui_up"):
		dirY += -2
		anim = "walk_torch"
	
	if Input.is_action_pressed("ui_right"):
		dirX += 2
		sprite.set_flip_h(false)
		torch_light.position.x = 8.109
		torch_light_ambient.position.x = 8.109
		shadow.scale.x = 1
		anim = "walk_torch"
		
	if Input.is_action_pressed("ui_down"):
		dirY += 2
		anim = "walk_torch"
		
	#Pick up Torch
	if(Input.is_action_just_pressed("ui_accept")):
		print('picked')
		
	if dirX > 1:
		$pushRight.set_enabled(true)
	else:
		$pushRight.set_enabled(false)

	if dirX < -1:
		$pushLeft.set_enabled(true)
	else:
		$pushLeft.set_enabled(false)		
		
	if dirY > 1:
		$pushDown.set_enabled(true)
	else:
		$pushDown.set_enabled(false)

	if dirY < -1:
		$pushUp.set_enabled(true)
	else:
		$pushUp.set_enabled(false)		
		
		
	if dirX == 0 and dirY == 0:
		anim = "idle_torch"
	
	motion = Vector2(dirX,dirY)
	#motion = motion.normalized()
	#move_and_collide(motion * vel * delta)
	translate(motion * vel * delta)

	
	global_position.x = clamp(global_position.x, 26, screen_size.x - 34)
	global_position.y = clamp(global_position.y, 26, screen_size.y - 34)
	
	if old_motion == motion:
		return
		
	old_motion = motion
	get_node("AnimationPlayer").play(anim)		

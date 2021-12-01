extends KinematicBody2D

# posicao minima 26
# posicao maxima 373
var vel = 50
onready var sprite = get_node( "Sprite" )
var anim = "idle_torch"
var motion = Vector2(0, 0)
var old_motion = Vector2(0, 0)
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	get_node("AnimationPlayer").play(anim)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dirX = 0
	var dirY = 0
	
	if Input.is_action_pressed("ui_left"):
		dirX += -2
		sprite.set_flip_h(true)
		anim = "walk_torch"
		
	if Input.is_action_just_released("ui_left") and (not Input.is_action_pressed("ui_up") or not Input.is_action_pressed("ui_down")):
		anim = "idle_torch"
		dirX = 0		
		
	if Input.is_action_pressed("ui_up"):
		dirY += -2
		anim = "walk_torch"

	if Input.is_action_just_released("ui_up") and (not Input.is_action_pressed("ui_left") or not Input.is_action_pressed("ui_right")):
		anim = "idle_torch"
		dirY = 0	
	
	if Input.is_action_pressed("ui_right"):
		dirX += 2
		sprite.set_flip_h(false)
		anim = "walk_torch"
		
	if Input.is_action_just_released("ui_right") and (not Input.is_action_pressed("ui_up") or not Input.is_action_pressed("ui_down")):
		anim = "idle_torch"
		dirX = 0
		dirY = 0
		
		
	if Input.is_action_pressed("ui_down"):
		dirY += 2
		anim = "walk_torch"
		
	if Input.is_action_just_released("ui_down") and (not Input.is_action_pressed("ui_left") or not Input.is_action_pressed("ui_right")):
		anim = "idle_torch"
		dirY = 0		
		
	#Pick up Torch	
	if(Input.is_action_just_pressed("ui_accept")):
		print('picked')
		
	motion = Vector2(dirX,dirY)
	translate(motion * vel * delta)
	
	global_position.x = clamp(global_position.x, 26, screen_size.x - 34)
	global_position.y = clamp(global_position.y, 26, screen_size.y - 34)
	
	if old_motion == motion:
		return
		
	old_motion = motion		
	get_node("AnimationPlayer").play(anim)

	

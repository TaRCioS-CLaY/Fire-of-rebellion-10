extends KinematicBody2D
class_name Minecart_side

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimationPlayer").play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

	
#func _physics_process(delta):
#
#	var motion = Vector2(0,0)
#	motion = motion.normalized()
#	move_and_collide(Vector2(0,0))

func move(dirX, dirY, push_speed, delta):
	move_and_slide(Vector2(dirX, dirY) * push_speed * delta)
	get_node("AnimationPlayer").play("moving")
	get_node("AnimationPlayer").queue("idle")


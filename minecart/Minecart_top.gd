extends KinematicBody2D
class_name Minecart_top

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func move(dirX, dirY, push_speed, delta):
	move_and_slide(Vector2(dirX, dirY) * push_speed * delta)
	get_node("AnimationPlayer").play("moving")
	get_node("AnimationPlayer").queue("idle")

extends KinematicBody2D
class_name Torch

var dirX := 0
var dirY := 0
func _physics_process(delta: float) -> void:
		move_and_collide(Vector2(dirX, 0) * delta * 0.3)
		yield($AnimationPlayer, "animation_finished")
		dirX = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func throw(directions: Vector2):
	$AnimationPlayer.play("throwed")
	dirX = directions.x
#	dirY = directions.y

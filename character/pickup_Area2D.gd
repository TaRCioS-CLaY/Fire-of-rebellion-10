extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pickable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func pick_item():
	if is_instance_valid( pickable ):
		pickable.queue_free()


func _on_pickup_Area2D_body_entered(body):
	if body.is_in_group("torchs"):
		pickable = body


func _on_pickup_Area2D_body_exited(body):
	pickable = null
	pass # Replace with function body.

extends Sprite


signal button_on
signal button_off

export var just_touch = false
export var id = ""

func _on_Area2D_body_entered(body):
	if body != self:
		emit_signal("button_on", id)
		frame = 0


func _on_Area2D_body_exited(body):
	if body != self:
		if not just_touch:
			emit_signal("button_off", id)
			frame = 1

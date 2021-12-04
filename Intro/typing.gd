extends RichTextLabel

export var time_to_type = 5.0

func _ready():
	$Tween.interpolate_property(
		self, "percent_visible",
		0.0, 1.0, time_to_type, Tween.TRANS_CUBIC, Tween.EASE_OUT
	)
	$Tween.start()


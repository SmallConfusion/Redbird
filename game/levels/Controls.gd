extends AnimatedSprite2D

var done := false

func _input(event):
	if Input.is_action_just_pressed("Flap"):
		done = true
		
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 1)

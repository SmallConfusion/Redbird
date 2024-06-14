extends AnimatedSprite2D

var falling := false

func _on_animation_finished():
	if not falling:
		play("default")

func flap():
	play("flap")

func begin_fall():
	play("fall")
	falling = true

func end_fall():
	play("default")
	falling = false

extends AnimatedSprite2D

var falling := false
var dead := false

func _on_animation_finished():
	if not dead:
		if falling:
			play("fall")
		else:
			play("default")

func flap():
	if not dead:
		play("flap")

func begin_fall():
	if not dead:
		play("fall")
		falling = true

func end_fall():
	if not dead:
		play("default")
		falling = false

func die():
	play("die")
	dead = true

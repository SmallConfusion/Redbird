extends Node2D

signal dead
signal life

@export var is_dead = false

func hit(damage):
	if not is_dead:
		SoundManager.play("boss", "die")
		visible = false
		is_dead = true
		emit_signal("dead")


func live():
	emit_signal("life")
	visible = true
	is_dead = false

extends Node2D

@export var forward := Vector2(1, 0)
@export var speed := 1.2

func _physics_process(delta):
	position += speed * forward


func _on_hurtbox_hit():
	queue_free()

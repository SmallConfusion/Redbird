extends Node2D

@export var speed := 0.4
@export var forward := Vector2(-1, 0)

func _physics_process(delta):
	position += speed * forward

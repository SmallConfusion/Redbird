extends Node2D

@export var forward := Vector2(1, 0)
@export var speed := 1.2

@onready var velocity := forward * speed
@onready var game_scene := $"../"

func _physics_process(_delta):
	velocity += game_scene.get_pull(position) / 10
	position += velocity


func _on_hurtbox_hit():
	queue_free()


func destroy():
	queue_free()

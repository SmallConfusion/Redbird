extends Node2D

@export var bullet_scene : PackedScene

var bullet_timer := 0.0
var bullet_cooldown := 1.0

@onready var game_scene := $"../"

func _physics_process(delta):
	bullet_timer -= delta
	
	if bullet_timer <= 0:
		bullet_timer = bullet_cooldown
		
		var instance = bullet_scene.instantiate()
		instance.position = position
		game_scene.add_child(instance)
		
		SoundManager.play("enemy", "fire")


func hit(damage):
	SoundManager.play("enemy", "die")
	queue_free()

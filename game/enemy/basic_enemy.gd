extends Node2D

@export var bullet_scene : PackedScene

@export var target_y_offset = 0

var accel_speed = 0.01
var max_speed = 0.2

var bullet_timer := 1.0
var bullet_cooldown := 1.0

var velocity := Vector2(0, 0)
var accel := Vector2(0, 0)

@onready var game_scene := $"../"

func _physics_process(delta):
	_handle_fire(delta)
	_move()


func _move():
	var target = Vector2(40, game_scene.get_player_position().y + target_y_offset)
	
	accel = (target - position).normalized() * accel_speed
	
	velocity += accel
	
	if velocity.length_squared() > max_speed ** 2:
		velocity = velocity.normalized() * max_speed
	
	position += velocity


func _handle_fire(delta):
	bullet_timer -= delta
	
	if bullet_timer <= 0:
		bullet_timer = bullet_cooldown
		
		var instance = bullet_scene.instantiate()
		instance.position = position
		game_scene.add_child(instance)
		
		SoundManager.play("enemy", "fire")


func hit(_damage):
	SoundManager.play("enemy", "die")
	queue_free()

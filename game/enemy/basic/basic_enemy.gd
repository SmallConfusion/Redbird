extends Node2D

@export var bullet_scene : PackedScene

@export var target_y_offset = 0

var accel_speed = 0.01
var max_speed = 0.2

var bullet_timer := 1.0
var bullet_cooldown := 1.0

var velocity := Vector2(0, 0)
var accel := Vector2(0, 0)

var enabled := false

@onready var game_scene := $"../"

func _physics_process(delta):
	if enabled:
		_handle_fire(delta)
		_move()
	elif position.x <= game_scene.get_bounds(0, 0, 0, -4)[3]:
		enabled = true
		


func _move():
	var x = game_scene.get_x_offset() + 40
	var y = game_scene.get_player_position().y + target_y_offset
	var target = Vector2(x, y)
	
	accel = (target - position).normalized() * accel_speed
	
	velocity += accel
	
	if velocity.length_squared() > max_speed ** 2:
		velocity = velocity.normalized() * max_speed
	
	position += velocity
	
	#var bounds = game_scene.get_bounds(1, 2, 4, 4)
	#
	#position.x = clamp(position.x, bounds[2], bounds[3])
	#position.y = clamp(position.y, bounds[0], bounds[1])


func _handle_fire(delta):
	bullet_timer -= delta
	
	if bullet_timer <= 0:
		bullet_timer = bullet_cooldown
		
		var instance = bullet_scene.instantiate()
		instance.position = position
		game_scene.add_child(instance)
		
		SoundManager.play("enemy", "fire")


func hit(_damage):
	if enabled:
		SoundManager.play("enemy", "die")
		queue_free()

func destroy():
	if enabled:
		queue_free()

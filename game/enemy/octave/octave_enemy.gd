extends Node2D

@export var bullet_scene : PackedScene

@export var y_range_min = -40
@export var y_range_max = 40
@export var target_speed = 0.2

var accel_speed = 0.03
var max_speed = 0.4

var bullet_timer := 1.0
var bullet_cooldown := 3.0

var velocity := Vector2(0, 0)
var accel := Vector2(0, 0)

var enabled := false

@onready var game_scene := $"../"

func _physics_process(delta):
	if enabled:
		_handle_fire(delta)
		_move()
	elif position.x <= game_scene.get_bounds(0, 0, 0, -5)[3]:
		enabled = true


func _move():
	var y = remap(sin(Time.get_ticks_msec() / 1000), -1, 1, y_range_min, y_range_max)
	var x = game_scene.get_x_offset() + 60
	var target = Vector2(x, y)
	
	accel = (target - position).normalized() * accel_speed
	
	velocity += accel
	
	if velocity.length_squared() > max_speed ** 2:
		velocity = velocity.normalized() * max_speed
	
	position += velocity
	
	#var bounds = game_scene.get_bounds(6, 5, 5, 5)
	#
	#position.x = clamp(position.x, bounds[2], bounds[3])
	#position.y = clamp(position.y, bounds[0], bounds[1])
	

func _handle_fire(delta):
	bullet_timer -= delta
	
	if bullet_timer <= 0:
		bullet_timer = bullet_cooldown
		$AnimatedSprite2D.play("fire")
		SoundManager.play("enemy", "fire")
		_shoot()


func _shoot():
	for i in range(8):
		var instance = bullet_scene.instantiate()
		instance.position = position
		instance.forward = Vector2(-1, 0).rotated(i * 0.2 - 0.7854)
		game_scene.add_child(instance)
		await get_tree().create_timer(0.02).timeout


func hit(_damage):
	SoundManager.play("enemy", "die")
	queue_free()

extends Node2D

@export var bullet_scene : PackedScene

@export var y_range_min = -40
@export var y_range_max = 40
@export var target_speed = 0.2

var spread := deg_to_rad(120)

var accel_speed := 0.03
var max_speed := 0.4

var bullet_timer : float
@export var bullet_cooldown := 3.0

var velocity := Vector2(0, 0)
var accel := Vector2(0, 0)

var enabled := false

@onready var game_scene := $"../../../"

var noise := FastNoiseLite.new()
var noise_influence := 20.0


func _ready():
	randomize()
	noise.seed = randi()
	bullet_timer = randf_range(0, bullet_cooldown / 3)


func _physics_process(delta):
	if enabled:
		_handle_fire(delta)
		_move()
	elif global_position.x <= game_scene.get_bounds(0, 0, 0, -5)[3]:
		enabled = true


func _move():
	var y = remap(sin(Time.get_ticks_msec() / 1000.0), -1, 1, y_range_min, y_range_max)
	var x = game_scene.get_x_offset() + 60
	
	var x_noise = noise.get_noise_1d(Time.get_ticks_msec() / 100.0) * noise_influence
	var y_noise = noise.get_noise_1d(Time.get_ticks_msec() / 100.0 + 10000) * noise_influence
	
	var target = Vector2(x + x_noise, y + y_noise)
	
	accel = (target - global_position).normalized() * accel_speed
	
	velocity += accel
	
	if velocity.length_squared() > max_speed ** 2:
		velocity = velocity.normalized() * max_speed
	
	global_position += velocity
	
	var bounds = game_scene.get_bounds(6, 5, 5, 5)
	
	global_position.y = clamp(global_position.y, bounds[0], bounds[1])
	

func _handle_fire(delta):
	bullet_timer -= delta
	
	if bullet_timer <= 0:
		bullet_timer = bullet_cooldown + randf() * 0.1 * bullet_cooldown
		$AnimatedSprite2D.play("fire")
		SoundManager.play("octave_enemy", "fire")
		_shoot()


func _shoot():
	for i in range(8):
		var instance = bullet_scene.instantiate()
		instance.position = global_position
		
		# i / 8.0 * spread - spread / 2.0 + spread / 16.0
		instance.forward = Vector2(-1, 0).rotated((2 * i * spread - 7 * spread) / 16)
		
		game_scene.add_child(instance)
		await get_tree().create_timer(0.02).timeout


func hit(_damage):
	if enabled:
		game_scene.score += 200
		SoundManager.play("octave_enemy", "die")
		queue_free()


func destroy():
	if enabled:
		queue_free()

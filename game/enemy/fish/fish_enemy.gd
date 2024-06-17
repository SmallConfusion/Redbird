extends Node2D

@export var bullet_scene : PackedScene

var accel_speed = 0.02
var max_speed = 0.5

@export var bullet_cooldown := 1.0
var bullet_timer : float

var velocity := Vector2(0, 0)
var accel := Vector2(0, 0)

var enabled := false

@onready var game_scene := $"../../.."


var noise := FastNoiseLite.new()
var noise_influence := 60.0

var spread := 0.2

func _ready():
	randomize()
	noise.seed = randi()
	bullet_timer = randf_range(0, bullet_cooldown / 3)
	


func _physics_process(delta):
	if enabled:
		_handle_fire(delta)
		_move()
	elif global_position.x <= game_scene.get_bounds(0, 0, 0, -8)[3]:
		enabled = true


func _move():
	var x = game_scene.get_x_offset() + 52
	var y = game_scene.get_player_position().y
	
	var x_noise = noise.get_noise_1d(Time.get_ticks_msec() / 200.0) * noise_influence * 0.5
	var y_noise = noise.get_noise_1d(Time.get_ticks_msec() / 200.0 + 10000) * noise_influence
	
	var target = Vector2(x + x_noise, y + y_noise)
	
	accel = (target - global_position).normalized() * accel_speed
	
	velocity += accel
	
	if velocity.length_squared() > max_speed ** 2:
		velocity = velocity.normalized() * max_speed
	
	position += velocity
	
	var bounds = game_scene.get_bounds(8, 8, 8, 8)
	
	global_position.y = clamp(global_position.y, bounds[0], bounds[1])


func _handle_fire(delta):
	bullet_timer -= delta
	
	if bullet_timer <= 0:
		bullet_timer = bullet_cooldown + randf() * 0.1 * bullet_cooldown
		
		var instance = bullet_scene.instantiate()
		instance.position = global_position
		
		instance.forward = Vector2(-1, 0).rotated(randi_range(-2, 2) * spread)
		
		game_scene.add_child(instance)
		
		SoundManager.play("basic_enemy", "fire")


func hit(_damage):
	if enabled:
		game_scene.score += 400
		SoundManager.play("basic_enemy", "die")
		queue_free()

func destroy():
	if enabled:
		queue_free()

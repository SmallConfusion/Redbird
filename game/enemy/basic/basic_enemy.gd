extends Node2D

signal dead

@export var bullet_scene : PackedScene

@export var target_y_offset = 0

var accel_speed = 0.01
var max_speed = 0.2

@export var bullet_cooldown := 1.0
var bullet_timer : float

var velocity := Vector2(0, 0)
var accel := Vector2(0, 0)

var enabled := false

@onready var game_scene := $"../../.."


var noise := FastNoiseLite.new()
var noise_influence := 20.0

@export var death_particles : PackedScene


func _ready():
	randomize()
	noise.seed = randi()
	bullet_timer = randf_range(0, bullet_cooldown / 3)
	


func _physics_process(delta):
	if enabled:
		_handle_fire(delta)
		_move()
	elif global_position.x <= game_scene.get_bounds(0, 0, 0, -4)[3]:
		enabled = true
		


func _move():
	var x = game_scene.get_x_offset() + 40
	var y = game_scene.get_player_position().y + target_y_offset
	
	var x_noise = noise.get_noise_1d(Time.get_ticks_msec() / 100.0) * noise_influence
	var y_noise = noise.get_noise_1d(Time.get_ticks_msec() / 100.0 + 10000) * noise_influence
	
	var target = Vector2(x + x_noise, y + y_noise)
	
	accel = (target - global_position).normalized() * accel_speed
	
	velocity += accel
	
	if velocity.length_squared() > max_speed ** 2:
		velocity = velocity.normalized() * max_speed
	
	position += velocity
	
	var bounds = game_scene.get_bounds(2, 2, 4, 4)
	
	global_position.y = clamp(global_position.y, bounds[0], bounds[1])


func _handle_fire(delta):
	bullet_timer -= delta
	
	if bullet_timer <= 0:
		bullet_timer = bullet_cooldown + randf() * 0.1 * bullet_cooldown
		
		var instance = bullet_scene.instantiate()
		instance.position = global_position
		game_scene.add_child(instance)
		
		SoundManager.play("basic_enemy", "fire")


func hit(damage):
	if enabled:
		emit_particles()
		game_scene.shake(0)
		game_scene.score += 100
		emit_signal("dead")
		queue_free()
		
		if damage != 2: # This happens when the boss dies
			SoundManager.play("basic_enemy", "die")

func emit_particles():
	var particles = death_particles.instantiate()
	particles.position = global_position
	game_scene.add_child(particles)
	

func destroy():
	if enabled:
		queue_free()

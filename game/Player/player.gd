extends Node2D

signal dead

var flap_accel := 0.75
var horizontal_accel := 0.03

var gravity := 0.006
var gravity_fall := 0.04

var friction = 0.99

var max_speed_x := 0.4

var max_speed_y := 0.2
var max_speed_y_fall := 0.5

var velocity := Vector2(0, 0)
var accel := Vector2(0, 0)

var hole_velocity := Vector2(0, 0)

var flap_timer := 0.0
var flap_cooldown := 0.5
var flap_cache = false

var shoot_timer := 0.0
var shoot_cooldown := 1.0
var shoot_cache := false

var max_input_cache := 0.2

var wall_bounce := 0.25

var is_dead := false

@export var bullet_scene : PackedScene
@export var fire_sound : AudioStream

@onready var game_scene := $"../"

var started := false


func _physics_process(delta):
	if Input.is_action_just_pressed("Flap"):
		started = true
	
	if not started:
		return
	
	_get_accel(delta)
	_apply_velocity()
	
	if not is_dead:
		_check_bounds()
		_fire(delta)


func _die():
	$AnimatedSprite2D.die()
	is_dead = true
	velocity = Vector2.ZERO
	accel = Vector2.ZERO
	emit_signal("dead")


func hit(_damage):
	_die()

func _fire(delta):
	shoot_timer -= delta
	
	if (Input.is_action_pressed("Fire") or shoot_cache) and shoot_timer <= 0:
		shoot_timer = shoot_cooldown
		shoot_cache = false
		
		var instance = bullet_scene.instantiate()
		instance.position = position
		game_scene.add_child(instance)
		SoundManager.play("player", "fire")
	elif Input.is_action_just_pressed("Fire") and shoot_timer <= max_input_cache:
		shoot_cache = true


func _flap(delta):
	flap_timer -= delta
	
	if (Input.is_action_pressed("Flap") or flap_cache) and flap_timer <= 0 and not is_dead:
		flap_timer = flap_cooldown
		flap_cache = false
		
		accel.y = -velocity.y - flap_accel
		$AnimatedSprite2D.play("flap")
		SoundManager.play("player", "flap")
	elif Input.is_action_just_pressed("Flap") and flap_timer <= max_input_cache:
		flap_cache = true
	

func _get_accel(delta):
	accel = Vector2(0, 0)
	
	if Input.is_action_just_pressed("Fall"):
		$AnimatedSprite2D.begin_fall()
	elif Input.is_action_just_released("Fall"):
		$AnimatedSprite2D.end_fall()
	
	if Input.is_action_pressed("Fall") or is_dead:
		accel.y += gravity_fall
	else:
		accel.y += gravity
	
	_flap(delta)
	
	accel.x = 0.0 if is_dead else Input.get_axis("Left", "Right") * horizontal_accel


func _apply_velocity():
	velocity *= friction
	velocity += accel
	
	if abs(velocity.x) > max_speed_x:
		velocity.x = max_speed_x * sign(velocity.x)
	
	if Input.is_action_pressed("Fall") or is_dead:
		velocity.y = min(velocity.y, max_speed_y_fall)
	else:
		velocity.y = min(velocity.y, max_speed_y)

	position += game_scene.get_pull(position)
	position += velocity
	position.x -= game_scene.get_x_speed()


func _check_bounds():
	var bounds = game_scene.get_bounds(1, 2, 4, 4)
	var error = false
	
	if position.y < bounds[0]:
		velocity.y = wall_bounce
		position.y = bounds[0]
		error = true
	
	elif position.y > bounds[1]:
		velocity.y = -wall_bounce
		position.y = bounds[1]
		error = true
	
	if position.x < bounds[2]:
		velocity.x = wall_bounce
		position.x = bounds[2]
		error = true
	
	elif position.x > bounds[3]:
		velocity.x = -wall_bounce
		position.x = bounds[3]
		error = true
	
	if error:
		SoundManager.play("player", "error")

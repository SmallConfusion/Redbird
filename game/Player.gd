extends Node2D

var flap_accel := 0.35
var horizontal_accel := 0.01

var gravity := 0.001
var gravity_fall := 0.01

var friction = 0.99

var max_speed_x := 0.1

var max_speed_y := 0.1
var max_speed_y_fall := 0.2

var velocity := Vector2(0, 0)
var accel := Vector2(0, 0)

func _process(delta):
	_get_accel()
	_apply_velocity()
	
	


func _get_accel():
	accel = Vector2(0, 0)
	
	if Input.is_action_just_pressed("Fall"):
		$AnimatedSprite2D.begin_fall()
	elif Input.is_action_just_released("Fall"):
		$AnimatedSprite2D.end_fall()
	
	if Input.is_action_pressed("Fall"):
		accel.y += gravity_fall
	else:
		accel.y += gravity
	
	if Input.is_action_just_pressed("Flap"):
		accel.y = -velocity.y - flap_accel
		$AnimatedSprite2D.play("flap")
		
	
	accel.x = Input.get_axis("Left", "Right") * horizontal_accel


func _apply_velocity():
	velocity *= friction
	velocity += accel
	
	if abs(velocity.x) > max_speed_x:
		velocity.x = max_speed_x * sign(velocity.x)
	
	if Input.is_action_pressed("Fall"):
		velocity.y = min(velocity.y, max_speed_y_fall)
	else:
		velocity.y = min(velocity.y, max_speed_y)

	position += velocity

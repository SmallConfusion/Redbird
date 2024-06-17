extends Node2D

@export var bullet_scene : PackedScene

@onready var game_manager = $"../../../.."

@export var bullet_timer := 1.0
@export var bullet_cooldown := 1.5

var enabled := false
var disabled := false

func _physics_process(delta):
	if $"..".dead:
		return
	
	if global_position.x <= game_manager.get_bounds(0, 0, 0, 0)[3]:
		enabled = true
	else:
		return

	bullet_timer -= delta

	var diff
	var angle

	if not disabled:
		diff = game_manager.get_player_position() - global_position
		angle = snapped(diff.angle() - PI, PI/4)
		rotation = angle
	
	
	if bullet_timer <= 0:
		bullet_timer = bullet_cooldown
		
		if not disabled:
			var bullet = bullet_scene.instantiate()
			bullet.forward = diff.normalized()
			bullet.position = global_position + Vector2.from_angle(angle) * -5
			bullet.speed = 1.3
			game_manager.add_child(bullet)
			SoundManager.play("boss", "fire")
		
	
func disable():
	disabled = true


func enable():
	disabled = false

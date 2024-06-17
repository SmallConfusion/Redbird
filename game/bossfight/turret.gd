extends Node2D

@export var bullet_scene : PackedScene

@onready var game_manager = $"../../../.."

@export var bullet_timer := 1.0
@export var bullet_cooldown := 1.5

var enabled := false
var disabled := false

func _physics_process(delta):
	if global_position.x <= game_manager.get_bounds(0, 0, 0, 0)[3]:
		enabled = true
	else:
		return

	if disabled:
		return

	var diff = game_manager.get_player_position() - global_position
	var angle = snapped(diff.angle() - PI, PI/4)
	rotation = angle
	
	bullet_timer -= delta
	
	if bullet_timer <= 0:
		bullet_timer = bullet_cooldown
		var bullet = bullet_scene.instantiate()
		bullet.forward = diff.normalized()
		bullet.position = global_position + Vector2.from_angle(angle) * -5
		bullet.speed = 1.5
		game_manager.add_child(bullet)
		SoundManager.play("boss", "fire")
		
	
func disable():
	disabled = true


func enable():
	disabled = false

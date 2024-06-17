extends Node2D

@export var enemy_scene : PackedScene
@export var hole_scene : PackedScene

@onready var game_manager := $"../../.."

@onready var eye1 = $Eye
@onready var eye2 = $Eye2

var spawning := false
var holes := false

var hole_cooldown = 8.0
var hole_timer = 0.0

var last_enemy

func _physics_process(delta):
	hole_timer -= delta
	
	if holes and hole_timer < 0:
		hole_timer = hole_cooldown
		_spawn_hole()


func _eye_dead():
	game_manager.score += 1000
	
	if eye1.is_dead and eye2.is_dead:
		if holes:
			last_enemy.hit(1)
			queue_free()
		
		elif spawning:
			holes = true
		
		else:
			spawning = true
			_spawn_enemy()

		await get_tree().create_timer(4).timeout
		eye1.live()
		eye2.live()


func _on_enemy_dead():
	await get_tree().create_timer(2).timeout
	_spawn_enemy()


func _spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position.y = (randf()-0.5) * 10
	enemy.enabled = true
	enemy.connect("dead", _on_enemy_dead)
	
	$"..".add_child(enemy)
	
	last_enemy = enemy


func _spawn_hole():
	var hole = hole_scene.instantiate()
	game_manager.add_child(hole)
	hole.position.x = global_position.x
	hole.position.y = 30
	game_manager.refresh_holes()

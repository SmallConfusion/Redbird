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

var dead := false


func _physics_process(delta):
	if dead:
		position.x = (randf() - 0.5) * 4
	
	hole_timer -= delta
	
	if holes and hole_timer < 0:
		hole_timer = hole_cooldown
		_spawn_hole()


func _eye_dead():
	if dead:
		return
	
	game_manager.score += 1000
	
	if eye1.is_dead and eye2.is_dead:
		if holes:
			kill()
		
		elif spawning:
			holes = true
		
		else:
			spawning = true
			_spawn_enemy()

		await get_tree().create_timer(4).timeout
		eye1.live()
		eye2.live()


func _on_enemy_dead():
	if dead:
		return
	
	await get_tree().create_timer(2).timeout
	_spawn_enemy()


func _spawn_enemy():
	if dead:
		return
	
	var enemy = enemy_scene.instantiate()
	enemy.position.y = (randf()-0.5) * 10
	enemy.enabled = true
	enemy.connect("dead", _on_enemy_dead)
	
	$"..".add_child(enemy)
	
	last_enemy = enemy


func _spawn_hole():
	if dead:
		return
	
	var hole = hole_scene.instantiate()
	game_manager.add_child(hole)
	hole.position.x = global_position.x
	hole.position.y = 30
	game_manager.refresh_holes()


func kill():
	dead = true
	
	last_enemy.hit(1)
	do_particles()
	
	await get_tree().create_timer(1).timeout
	
	position.x = 0
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(0, 144), 5.5).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(queue_free)
	

func do_particles():
	for particles in [$ExplosionParticles, $ExplosionParticles2, $ExplosionParticles3, $ExplosionParticles4]:
		particles.start()
		await get_tree().create_timer(0.3).timeout

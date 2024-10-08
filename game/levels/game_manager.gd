extends Node2D

@export var hole_pull_curve : Curve
@export var hole_pull_x_size := 60
@export var hole_pull_y_size := 2

@export var camera_speed := 0.2

@export_node_path("Node2D") var finish
@export_node_path("Node2D") var player

@export var level_index := 0

var holes : Array

var scene_manager

var waves
var wave := 0

var wave_position = INF

var started := false

var score := 0

func init(scene):
	scene_manager = scene


func _ready():
	refresh_holes()
	get_node(finish).connect("win", win)
	get_node(player).connect("dead", restart)
	
	waves = $Waves.get_children()
	
	$Overlay.game_manager = self


func _physics_process(_delta):
	if Input.is_action_just_pressed("Flap"):
		started = true
	
	if not started:
		return
	
	if len(waves) > wave and waves[wave].number_of_enemies() == 0:
		wave += 1
		
	if len(waves) > wave:
		wave_position = waves[wave].position.x - 80
	else:
		wave_position = INF
	
	$Camera2D.position.x = min($Camera2D.position.x + camera_speed, wave_position)


func get_player_position() -> Vector2:
	return $Player.position


func get_pull(check_position : Vector2):
	var hole_velocity = Vector2(0, 0)
	
	for hole in holes:
		var diff = hole.position - check_position
		
		if diff.length_squared() <= 3600:
			var pull_strength = hole_pull_curve.sample_baked(diff.length() / hole_pull_x_size) * hole_pull_y_size
			hole_velocity += pull_strength * diff.normalized()
			
	return hole_velocity


func get_bounds(n, s, w, e):
	return [-41 + n, 63 - s, -80 + w + get_x_offset(), 80 - e + get_x_offset()]


func get_x_offset():
	return $Camera2D.position.x


func get_x_speed():
	if $Camera2D.position.x != wave_position:
		return -camera_speed
	else:
		return 0


func win():
	scene_manager.beat_level(level_index)
	scene_manager.load_menu()


func restart():
	await get_tree().create_timer(2.0).timeout
	scene_manager.load_menu()


func get_progress():
	return $Camera2D.position.x / (waves[len(waves)-1].position.x - 80)


func get_remaining_waves() -> int:
	return len(waves) - wave - 1


func get_remaining_enemies() -> int:
	var enemies = 0
	
	for i in range(wave, len(waves)):
		enemies += waves[i].number_of_enemies()
	
	return enemies - 1


func get_bullet_count() -> int:
	return len(get_tree().get_nodes_in_group("bullet"))


func refresh_holes():
	holes = get_tree().get_nodes_in_group("hole")


func shake(type):
	scene_manager.shake(type)

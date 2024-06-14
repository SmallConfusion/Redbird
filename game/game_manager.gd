extends Node2D

@export var hole_pull_curve : Curve
@export var hole_pull_x_size := 60
@export var hole_pull_y_size := 2

var holes : Array


func _ready():
	holes = get_tree().get_nodes_in_group("hole")


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

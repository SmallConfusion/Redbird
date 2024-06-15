extends Node2D

signal destroy

var camera

var min_x := -90.
var max_x := 90.
var min_y := -50.
var max_y := 74.

var base_x : float
var camera_base_x : float

@export var min_parallax : float
@export var max_parallax : float

var parallax : float


func init(on_screen : bool):
	randomize()
	
	var y = randi_range(min_y, max_y)
	var x = randi_range(min_x, max_x) if on_screen else max_x
	
	x += camera.position.x
	
	base_x = x

	position.x = x
	position.y = y
	
	camera_base_x = camera.position.x
	
	parallax = randf_range(min_parallax, max_parallax)


func _process(_delta):
	position.x = (camera.position.x - camera_base_x) * parallax + base_x
	
	if position.x < camera.position.x + min_x:
		emit_signal("destroy")
		queue_free()

extends Node2D

@export_node_path("Camera2D") var camera

@export var star_scenes : Array[PackedScene]

var target_stars := 20

func _ready():
	for i in range(target_stars):
		_new_star(true)


func _new_star(on_screen):
	var star = star_scenes.pick_random().instantiate()
	star.camera = get_node(camera)
	star.init(on_screen)
	star.connect("destroy", _new_star.bind(false))
	add_child(star)

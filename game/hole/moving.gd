extends Node2D


@export var type := 0
@export var end_position := Vector2(0, 0)
@export var time := 5.0

@onready var base = position

func _process(delta):
	var weight = fmod(Time.get_ticks_msec() / 1000.0, time * 2) / time
	
	if weight > 1:
		weight = abs(2-weight)
	
	position = ease(weight, -2.0) * end_position + base

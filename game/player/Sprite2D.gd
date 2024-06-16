extends Sprite2D

@onready var stay_position = global_position


func _process(delta):
	global_position = stay_position

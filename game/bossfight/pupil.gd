extends Sprite2D

@onready var scene_manager = $"../../../../../"
@onready var base_position := position


func _process(delta):
	var diff = scene_manager.get_player_position() - global_position
	diff = diff.normalized() * 2
	position = base_position + diff

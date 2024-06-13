extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	load_main()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_main():
	var instance = preload("res://game/test.tscn").instantiate()
	%SubViewport.add_child(instance)

extends Control


func _ready():
	load_main()


func _process(_delta):
	pass

func load_main():
	var instance = preload("res://game/test.tscn").instantiate()
	%SubViewport.add_child(instance)

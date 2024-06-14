extends Control


func _ready():
	load_main()
	MusicManager.updated.connect(on_music_manager_updated)


func _process(_delta):
	pass

func load_main():
	var instance = preload("res://game/test.tscn").instantiate()
	%SubViewport.add_child(instance)


func on_music_manager_updated():
	MusicManager.play("music", "main", 0)

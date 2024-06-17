extends CanvasLayer


func _ready():
	if not OS.is_debug_build():
		get_tree().paused = true
		await get_tree().create_timer(2.9).timeout
		get_tree().paused = false
		await get_tree().create_timer(0.1).timeout
	
	queue_free()

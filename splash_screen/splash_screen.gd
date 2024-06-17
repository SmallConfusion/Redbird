extends CanvasLayer


func _ready():
	if not OS.is_debug_build():
		await get_tree().create_timer(0.05).timeout
		get_tree().paused = true
		await get_tree().create_timer(3).timeout
		
		var tween = get_tree().create_tween()
		tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property($SplashScreen, "position", Vector2(0, 720), 1)
		
		await tween.finished
		get_tree().paused = false
	
	queue_free()

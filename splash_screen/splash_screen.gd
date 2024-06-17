extends CanvasLayer


func _ready():
	if not OS.is_debug_build():
		get_tree().paused = true
		await get_tree().create_timer(2).timeout
		get_tree().paused = false
		await get_tree().create_timer(0.05).timeout
		get_tree().paused = true
		
		var tween = get_tree().create_tween()
		tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		tween = tween.tween_property($SplashScreen, "modulate", Color(1, 1, 1, 0), 2)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN_OUT)
		
		await tween.finished
		
		get_tree().paused = false
	
	queue_free()

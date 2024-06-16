extends CanvasLayer


func _process(delta):
	$ColorRect2/FPSCounter.number = Engine.get_frames_per_second()
	$ColorRect2/TimeCounter.number = Time.get_unix_time_from_system()
	$ColorRect2/MsecCounter.number = Time.get_ticks_msec() / 1000

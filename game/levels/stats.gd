extends CanvasLayer

var progress_length := 151.0
var progress_base : Vector2

var game_manager

func _ready():
	progress_base = %ProgressIndicator.position


func _process(delta):
	$ColorRect2/FPSCounter.number = Engine.get_frames_per_second()
	$ColorRect2/TimeCounter.number = Time.get_unix_time_from_system()
	$ColorRect2/MsecCounter.number = Time.get_ticks_msec() / 1000.0
	
	%ProgressIndicator.position = progress_base + Vector2(game_manager.get_progress() * progress_length, 0)

extends CanvasLayer

var progress_length := 151.0
var progress_base : Vector2

var game_manager

func _ready():
	progress_base = %ProgressIndicator.position


func _process(delta):
	%FPSCounter.number = Engine.get_frames_per_second()
	%TimeCounter.number = Time.get_unix_time_from_system()
	%MsecCounter.number = Time.get_ticks_msec() / 1000.0
	
	%ProgressIndicator.position = progress_base + Vector2(game_manager.get_progress() * progress_length, 0)
	%ScoreCounter.text = "%08d" % game_manager.score
	%BinScoreCounter.number = game_manager.score
	
	%WaveCounter.text = "Waves: %d" % game_manager.get_remaining_waves()
	%EnemyCounter.number = game_manager.get_remaining_enemies()
	%BulletCounter.number = game_manager.get_bullet_count()
	
	%ProgressCounter.number = game_manager.get_x_offset()

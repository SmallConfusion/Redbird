extends Node2D

signal win


func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		SoundManager.play("egg", "win")
		emit_signal("win")

extends Node2D

signal win


func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		emit_signal("win")

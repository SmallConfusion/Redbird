extends Area2D

signal hit

var damage := 1

var used := false

func _on_area_entered(area):
	if area.has_method("hit") and not used:
		area.hit(damage)
		used = true
		emit_signal("hit")

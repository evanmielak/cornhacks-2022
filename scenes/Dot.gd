extends Area2D

signal dot_collected

func _on_Dot_body_entered(body):
	if body.is_in_group("Player"):
		collected()

func collected():
	emit_signal("dot_collected")
	Global.dot_collected = true
	queue_free()
	print(Global.dots)

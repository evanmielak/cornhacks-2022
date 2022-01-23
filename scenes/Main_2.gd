extends Node2D

export onready var dots = 140
	
func _on_Dot1_dot_collected():
	dots = dots - 1
	var DotsRemaining = "Dots: " +String(dots)
	Global.dots-=1
	if dots == 0:
		get_tree().change_scene("res://scenes/Main_3.tscn")

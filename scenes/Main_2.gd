extends Node2D

var dots = 100

func _on_Dot1_dot_collected():
	dots = dots - 1
	var DotsRemaining = "Dots: " +String(dots)
	Global.dots-=1

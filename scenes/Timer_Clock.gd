extends Label

var time = 0
var timer_on = false

func _process(delta):
	if(timer_on):
		time += delta
	
	var milli = fmod(time, 1) * 1000
	var seconds = fmod(time, 60)
	var mins = fmod(time, 60*60) / 60
	
	var time_passed = "%02d:%02d:%03d" % [mins, seconds, milli]
	text = time_passed# + ":" + var2str(time)
	
	


func _on_Reset_Button_pressed():
	time = 0


func _on_Stop_Button_pressed():
	timer_on = false


func _on_Start_Button_pressed():
	timer_on = true

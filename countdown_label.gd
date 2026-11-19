extends Label

@onready var timer = $"../CountdownTimer"

func process_time_text (time : float) :
	var time_sec = fmod(time, 60)
	var time_min = floor(time/60)
	var time_hrs = floor(time_min/60)
	time_min = fmod(time_min, 60)
	var time_day = floor(time_hrs/24)
	time_hrs = fmod(time_hrs, 24)
	
	return "%03d %02d:%02d:%02d" % [time_day, time_hrs, time_min, time_sec]

func update_timer_text(timer_text = timer.time_left) :
	
	text = process_time_text(timer_text)

func _onready() :
	update_timer_text()
	await get_tree().create_timer(0.5).timeout
	
func _process(delta) :
	update_timer_text()

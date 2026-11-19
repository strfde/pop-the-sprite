extends PanelContainer

signal timer_timeout()

@onready var timer = $CountdownTimer
@onready var label = $CountdownLabel

func aux_fxn() :
	timer_timeout.emit()

func reset_timer(new_time : float) :
	label.update_timer_text(new_time)
	timer.start(new_time)

func _ready() -> void:
	timer.timeout.connect(aux_fxn)

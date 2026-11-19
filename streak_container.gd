extends PanelContainer

@onready var label = $"MarginContainer/Label"


func update_streak(value_change : int) :
	label.text = str(int(label.text) + value_change)
	
func set_streak(value) :
	label.text = str(value)
	
func _ready() -> void:
	set_streak(0)

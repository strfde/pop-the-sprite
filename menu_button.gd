extends Button

signal open_menu()

func aux_fxn() :
	open_menu.emit()

func _ready() -> void:
	pressed.connect(aux_fxn)

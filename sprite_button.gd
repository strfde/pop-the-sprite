extends TextureButton

var button_id = -1
signal chosen_sprite(b_id)

func aux_fxn() :
	flip_h = true
	chosen_sprite.emit(button_id)
	
func set_button_id(new_button_id) :
	button_id = new_button_id

func paint_sprite(new_texture) :
	modulate = new_texture
	
func _ready() -> void:
	pressed.connect(aux_fxn)
	

extends CenterContainer

@onready var sprite = $HBoxContainer/Sprite


func load_sprite(new_texture) :
	sprite.modulate = new_texture

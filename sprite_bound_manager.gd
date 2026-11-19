extends Node2D

signal check_match(button_id)

# the grid that holds sprites
@onready var sprite_container = $"../MarginContainer/VBoxContainer/SpriteContainer/MarginContainer/Grid"
# the whole block of sprite container
@onready var sprite_container_parent = %SpriteContainer
@onready var msg_panel = $"../MarginContainer/VBoxContainer/MsgPanel"

var button = preload("res://sprite_button.tscn")

func aux_fxn(button_id) :
	check_match.emit(button_id)

func show_sprite_container() :
	msg_panel.visible = false
	sprite_container_parent.visible = true
	
func hide_sprite_container() :
	sprite_container_parent.visible = false
	msg_panel.visible = true

func free_sprites() :
	while get_child_count() > 0:
		var last_child = get_child(-1)
		remove_child(last_child)
		if not last_child.is_queued_for_deletion() :
			last_child.queue_free()

func make_sprite_tiles(textures : Dictionary) :
		
	for i in textures :
		var new_child = button.instantiate()
		new_child.paint_sprite(textures[i])
		new_child.set_button_id(i)
		new_child.chosen_sprite.connect(aux_fxn)
		
		sprite_container.add_child(new_child)
	
func _ready() -> void:
	free_sprites()

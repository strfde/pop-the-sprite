extends Node2D

enum phase {CHOOSE, WAIT}

@onready var header = $"../MarginContainer/VBoxContainer/Header"
@onready var pop_question = $"../MarginContainer/VBoxContainer/PopQuestion"
@onready var sprite_bound_manager = $"../SpriteBoundManager"

var chosen_one = -1
var curr_phase = phase.CHOOSE
var initial_countdown = 120.8


var textures = {
	0: Color("234556"),
	1: Color("E63946"),
	2: Color("457B9D"),
	3: Color("A8DADC"),
	4: Color("F1FAEE"),
	5: Color("FFB703"),
	6: Color("FB8500"),
	7: Color("6A4C93"),
	8: Color("1982C4"),
	9: Color("8AC926"),
	10: Color("FF595E"),
	11: Color("6D6875"),
	12: Color("B5838D"),
	13: Color("E5989B"),
	14: Color("FFCDB2"),
	15: Color("355070"),
	16: Color("EAAC8B"),
	17: Color("2A9D8F"),
	18: Color("264653"),
	19: Color("E9C46A"),
	20: Color("F4A261"),
	21: Color("E76F51"),
	22: Color("606C38"),
	23: Color("283618"),
	24: Color("DDA15E"),
	25: Color("BC6C25"),
	26: Color("7209B7"),
	27: Color("3A0CA3"),
	28: Color("4361EE"),
	29: Color("4CC9F0"),
	30: Color("F72585"),
	31: Color("B5179E"),
	32: Color("560BAD"),
	33: Color("480CA8"),
	34: Color("4895EF"),
	35: Color("4D908E"),
	36: Color("577590"),
	37: Color("F94144"),
	38: Color("F3722C"),
	39: Color("F8961E"),
	40: Color("90BE6D"),
	41: Color("43AA8B"),
	42: Color("277DA1"),
	43: Color("9B5DE5"),
	44: Color("F15BB5"),
	45: Color("FEE440"),
	46: Color("00BBF9"),
	47: Color("00F5D4"),
	48: Color("8338EC"),
	49: Color("3A86FF"),
	50: Color("FF006E"),
	51: Color("FB5607"),
	52: Color("FFBE0B"),
	53: Color("588157"),
	54: Color("3A5A40"),
	55: Color("A3B18A"),
	56: Color("DAD7CD"),
	57: Color("BC4749"),
	58: Color("386641"),
	59: Color("6A994E"),
	60: Color("A7C957"),
	61: Color("F2E8CF"),
	62: Color("5F0F40"),
	63: Color("9A031E"),
	64: Color("FB8B24"),
	65: Color("E36414"),
	66: Color("0F4C5C"),
	67: Color("219EBC"),
	68: Color("8ECAE6"),
	69: Color("023047"),
	70: Color("FFB4A2"),
	71: Color("E5989B"),
	72: Color("B5838D"),
	73: Color("6D6875"),
	74: Color("CDB4DB"),
	75: Color("FFC8DD"),
	76: Color("FFAFCC"),
	77: Color("BDE0FE"),
	78: Color("A2D2FF"),
	79: Color("606C38"),
	80: Color("D4A373"),
	81: Color("CCD5AE"),
	82: Color("FAEDCD"),
	83: Color("FEFAE0"),
	84: Color("E63946"),
	85: Color("1D3557"),
	86: Color("457B9D"),
	87: Color("F4D35E"),
	88: Color("EE964B"),
	89: Color("F95738"),
	90: Color("386FA4"),
	91: Color("59A5D8"),
	92: Color("84D2F6"),
	93: Color("91E5F6"),
	94: Color("133C55"),
	95: Color("386FA4"),
	96: Color("4F6D7A"),
	97: Color("56A3A6"),
	98: Color("7EA16B"),
	99: Color("C2C5BB")
	}
	
func handle_timeout() :
	if curr_phase == phase.WAIT :
		curr_phase = phase.CHOOSE
		load_phase()
		
	else :
		curr_phase = phase.WAIT
		header.streak_container.set_streak(0)
		load_phase()

func show_menu_popup() :
	$"../MenuPopup".show()

func check_chosen_sprite(button_id) :
	if button_id == chosen_one :
		print("success")
		header.streak_container.update_streak(+1)
	else :
		print("failure")
		header.streak_container.set_streak(0)
		
	curr_phase = phase.WAIT
	load_phase()	

func fill_sprite_container() :
	# var sprite_list = make_random_generator()
	sprite_bound_manager.make_sprite_tiles(textures)
	
func update_pop_question(blank = false) :
	if blank :
		chosen_one = -1
		pop_question.load_sprite(Color(0,0,0,1))
		return
	chosen_one = randi() % len(textures)
	pop_question.load_sprite(textures[chosen_one])

func load_phase() :
	if curr_phase == phase.CHOOSE :
		sprite_bound_manager.show_sprite_container()
		fill_sprite_container()
		update_pop_question()
		
	else :
		sprite_bound_manager.hide_sprite_container()
		sprite_bound_manager.free_sprites()
		update_pop_question(true)
		
	header.countdown_container.reset_timer(initial_countdown)

func _ready() -> void:	
	
	sprite_bound_manager.check_match.connect(check_chosen_sprite)
	header.countdown_container.timer_timeout.connect(handle_timeout)
	header.menu_button.open_menu.connect(show_menu_popup)
	
	curr_phase = phase.CHOOSE
	load_phase()

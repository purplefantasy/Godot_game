extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var cards = [$Card1,$Card2,$Card3,$Card4,$Card5,$Card6]

#----------------card data-----------------
	
onready var game = get_parent()
var pause = false
enum Card_types {attack, defand, function, curse}
enum Card_target_types {selftarget, all_target, enemy_target}
onready var player = $"Player"
var atk = 0
var multiple = 1
var frequency = 1 
var hp_anime_time = 0.01
var atk_sum = 0

var player_class = 0
var use_card = false
var attack_enemy = [[],[],[],[]]
var timer = 0
var player_turn = true
onready var enemy = [$"Enemy", $"Enemy2", $"Enemy3"]
onready var card_data = get_parent().get_node("Card_data")
var win = false
onready var reward = get_parent().get_node("Reward")
onready var player_state = get_parent().get_node("Player_state")

func start():
	player.hp = player_state.hp
	player.max_hp = player_state.max_hp
	for i in 4:
		get_child(i).restart()
	get_node("Deck").start()
	get_node("Used_deck").start()
	get_node("Clock").restart()
	attack_enemy = [[],[],[],[]]
	atk = 0
	multiple = 1
	frequency = 1
	atk_sum = 0
	use_card = true
	timer = 0
	player_turn = true
	win = false
	for i in 6:
		card_data.new_index(get_node("Deck").draw_card(), i)
		get_child(4+i).transform[2].x = get_node("Deck").transform[2].x
		get_child(4+i).transform[2].y = get_node("Deck").transform[2].y
		get_child(4+i).moving = true
	pass

func attack_player(num):
	attack_enemy[3].push_back(num)

func buff_target(buff_index, target, num):
	if target == 3:
		player.get_node("buff").buff_add(buff_index, num)
	else:
		enemy[target].get_node("buff").buff_add(buff_index, num)
	pass

func attack(target, card_pos):
	var use_card_index = card_data.card_index[card_pos]
	if card_data.card_type[card_pos] == Card_types.attack:
		var j = 0
		if use_card_index == 3:
			frequency = 1
		for i in card_data.card_frequency[card_pos]*frequency:
			if use_card_index == 1 :
				attack_enemy[target].push_back(card_data.card_power[card_pos]+atk_sum*multiple+atk)
			elif use_card_index == 3:
				attack_enemy[target].push_back(card_data.card_power[card_pos]+player.get_node("buff").buffs[0]*10*multiple+atk)
			elif use_card_index == 8:
				if player.hp_rate > 0.25:
					attack_enemy[target].push_back(atk+player.hp_lose*multiple)
				else:
					attack_enemy[target].push_back(atk+player.hp_lose*multiple*2)
			else:
				attack_enemy[target].push_back(card_data.card_power[card_pos]*multiple+atk)
			j += 1
		atk_sum += j
		if target == 3:
			atk_sum = 0
		
		
	if card_data.card_type[card_pos] == Card_types.function:
		if card_data.card_have_buff[card_pos]:
			for i in 5:
				if card_data.buff_type[card_pos][i] >= 0:
					if target > 2:
						if use_card_index == 5:
							player.get_node("buff").buffs[card_data.buff_type[card_pos][i]] *= 2
							player.get_node("buff").load_buff(card_data.buff_type[card_pos][i], false)
						else:
							player.get_node("buff").buff_add(card_data.buff_type[card_pos][i] , 1)
					else:
						get_child(target).get_node("buff").buff_add(card_data.buff_type[card_pos][i] , 1)
		if use_card_index == 9:
			player.shield += player.hp/2
			player.hp -= player.hp/2
	use_card = true
	pass

onready var battle_deck = get_node("Deck")
onready var player_deck = get_parent().get_node("Player_deck")
func battle_start():
	battle_deck.cards = []
	battle_deck.cards += player_deck.cards
	get_node("Deck").rng.randomize()
	get_node("Used_deck").rng.randomize()
	restart()

func clear():
	for i in get_node("damage_text").get_child_count():
		get_node("damage_text").get_child(i).queue_free()

func Damage(pos, num):
	var temp = num
	var be_shield = 0
	if get_child(pos).shield > 0:
		if num <= get_child(pos).shield :
			get_child(pos).shield -= num
			be_shield = 2
		else:
			get_child(pos).shield = 0
			num -= get_child(pos).shield
			get_child(pos).hp -= num
			be_shield = 1
	else:
		get_child(pos).hp -= num
	Damage_text(pos,temp, be_shield)
	
func restart():
	for i in 4:
		get_child(i).restart()
	get_node("Deck").restart()
	get_node("Used_deck").restart()
	get_node("Clock").restart()
	attack_enemy = [[],[],[],[]]
	atk = 0
	multiple = 1
	frequency = 1
	atk_sum = 0
	use_card = true
	timer = 0
	player_turn = true
	win = false
	for i in 6:
		card_data.new_index(get_node("Deck").draw_card(), i)
		get_child(4+i).transform[2].x = get_node("Deck").transform[2].x
		get_child(4+i).transform[2].y = get_node("Deck").transform[2].y
		get_child(4+i).moving = true
	
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 6:
		card_data.new_index($".".get_node("Deck").draw_card(), i)
	card_data.index_card_discript()
	for i in 6:
		if card_data.card_index[i] >=0:
			card_data.card_discript[i] = card_data.index_card_discript_[card_data.card_index[i]]
		else:
			card_data.card_discript[i] = card_data.index_card_discript_[-card_data.card_index[i]-1]
		cards[i].get_node("RichTextLabel").bbcode_text = card_data.card_discript[i]
	pass # Replace with function body.

func Damage_text(pos,num, be_shield):
	var damage = load("res://prefab/Damage.tscn").instance()
	if pos < 3:
		damage.transform[2].x = get_child(pos).transform[2].x + get_child(pos).get_rect().size.x/2
		damage.transform[2].y = get_child(pos).transform[2].y + get_child(pos).get_rect().size.y/2
	else:
		damage.transform[2].x = player.transform[2].x + player.frames.get_frame("default", 0).get_size().x/2
		damage.transform[2].y = player.transform[2].y + player.frames.get_frame("default", 0).get_size().y/2
	if be_shield == 2:
			damage.get_node("Damage").bbcode_text = "[color=#0000E3]" + String(num) + "[/color]"
	if be_shield == 1:
			damage.get_node("Damage").bbcode_text = "[color=#FF8000]" + String(num) + "[/color]"
	if be_shield == 0:
			damage.get_node("Damage").bbcode_text = "[color=#CE0000]" + String(num) + "[/color]"
	get_node("damage_text").add_child(damage)
	pass
	
func enemy_alive(index):
	if enemy[index].hp <= 0:
		return false
	var sum = 0
	for i in attack_enemy[index].size():
		sum += attack_enemy[index][i]
	if enemy[index].hp + enemy[index].shield < sum:
		return false
	return true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if win:
		$".".visible = false
		game.game_time = get_node("Clock").timer
		reward.visible = true
		player_state.hp = player.hp
		restart()
	frequency = player.get_node("buff").buffs[0]+1
	multiple = player.get_node("buff").buffs[1]+1
	if use_card:
		use_card = false
		card_data.index_card_discript()
		for i in 6:
			card_data.card_discript[i] = card_data.index_card_discript_[card_data.card_index[i]]
			cards[i].get_node("RichTextLabel").bbcode_text = card_data.card_discript[i]
	if attack_enemy != [[],[],[],[]]:
		timer += delta
		if timer > hp_anime_time:
			for i in 4:
				if attack_enemy[i] != []:
					var temp = attack_enemy[i].pop_front()
					Damage(i,temp)
			timer -= hp_anime_time
			for i in 3:
				if !enemy_alive(i):
					enemy[i].alive = false
					enemy[i].action = false
	else:
		if !enemy_alive(0) and !enemy_alive(1) and !enemy_alive(2):
			win = true
	pass

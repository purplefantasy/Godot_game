extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	old_max_hp = max_hp
	load_intention()
	$HP/Label.text = String(hp) + "/" + String(max_hp)
	pass # Replace with function body.
	
onready var battle = $".".get_parent()
onready var enemy_data = get_parent().get_parent().get_node("Enemy_data")
onready var pos = $".".get_index()
onready var game = get_parent().get_parent()

var atk_mul = 1
var atk_add = 0
var atk_f = 1
var def_mul = 1
var def_add = 0



var index = 0
onready var max_hp = enemy_data.max_hp[index]
onready var hp = max_hp
var shield = 0
var hp_rate
onready var turn_time = enemy_data.first_attack_time[index] + enemy_data.wait_time[index] * pos
onready var real_turn_time = turn_time 
onready var speed = enemy_data.speed[index]
onready var attack_power = enemy_data.attack_power[index]
onready var defand_power = enemy_data.defand_power[index]
onready var heal_power = enemy_data.heal_power[index]
onready var buffs = enemy_data.start_buffs[index]
onready var action_types = enemy_data.action_types[index][pos]
var turn_num = 0
var action = false
var timer = 0.0
var moving = false
var anime_time = 1.0
onready var old_turn_time = turn_time
var old_max_hp
var alive = true
onready var use_buffs = enemy_data.use_buffs[index][pos]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func enemy_move():
	if alive:
		for i in action_types[turn_num % action_types.size()].size():
			if action_types[turn_num % action_types.size()][i] == 0:
				battle.attack_player(attack_power[0])
			if action_types[turn_num % action_types.size()][i] == 1:
				shield += defand_power
			if action_types[turn_num % action_types.size()][i] == 2:
				for j in use_buffs[turn_num % action_types.size()].size():
					battle.buff_target(use_buffs[turn_num % action_types.size()][j][0], 3, use_buffs[turn_num % action_types.size()][j][1])
			if action_types[turn_num % action_types.size()][i] == 3:
				battle.attack_player(attack_power[1])
			if action_types[turn_num % action_types.size()][i] == 4:
				hp += heal_power
				if hp > max_hp:
					hp = max_hp
		turn_time += speed
		moving = true

func restart():
	turn_time = enemy_data.first_attack_time[index] + enemy_data.wait_time[index] * pos
	real_turn_time = turn_time + game.game_time
	hp = max_hp
	shield = 0
	moving = false
	action = false
	visible = true
	alive = true
	$HP/Sprite2.scale.x = 1.0
	modulate.a = 1.0
	buffs = enemy_data.start_buffs[index]
	turn_num = 0
	timer = 0.0
	load_intention()

func load_intention():
	for i in action_types[turn_num % action_types.size()].size():
		if action_types[turn_num % action_types.size()][i] == 0:
			$RichTextLabel.bbcode_text = "[center]" + String(attack_power[0]) + "[/center]"
		if action_types[turn_num % action_types.size()][i] == 1:
			$RichTextLabel.bbcode_text = "[center][color=#0000E3]" + String(defand_power) + "[/color][/center]"
		if action_types[turn_num % action_types.size()][i] == 2:
			$RichTextLabel.bbcode_text = "[center][color=#7B16B9]Curse[/color][/center]"
		if action_types[turn_num % action_types.size()][i] == 3:
			$RichTextLabel.bbcode_text = "[center]" + String(attack_power[1]) + "[/center]"
		if action_types[turn_num % action_types.size()][i] == 4:
			$RichTextLabel.bbcode_text = "[center][color=#49FF33]" + String(heal_power[1]) + "[/color][/center]"
	pass

func _process(delta):
	if !alive and visible:
		modulate.a -= delta
		if modulate.a <= 0:
			visible = false
			modulate.a = 1.0
	if moving:
		timer += delta
		if timer >= anime_time:
			moving = false
			action = false
			real_turn_time += speed
			turn_num += 1
			load_intention()
			timer = 0.0
			for i in 3:
				battle.get_node("Clock").get_child(i).change_time()
	else:
		old_turn_time = turn_time
	if hp < 0:
		hp = 0
	if alive:
		if hp == 0:
			alive = false
			action = false
			moving = false
		if turn_time < 0 and pos == 0:
			enemy_move()
		elif turn_time < 0 and !battle.enemy[0].action and pos == 1:
			enemy_move()
		elif turn_time < 0 and !battle.enemy[0].action and !battle.enemy[1].action and pos == 2:
			enemy_move()
	if !battle.enemy[0].action and !battle.enemy[1].action and !battle.enemy[2].action:
		battle.player_turn = true
	hp_rate = float(hp) / (float(max_hp) + float(shield))
	$HP/Sprite.scale.x = hp_rate
	$HP/Sprite3.scale.x = (float(hp) + float(shield) )/ (float(max_hp) + float(shield))
	if hp_rate <= 0.2 and $HP/Sprite.texture != load("res://Image/HP_bar4.png"):
		$HP/Sprite.texture = load("res://Image/HP_bar4.png")
	elif hp_rate > 0.2 and $HP/Sprite.texture != load("res://Image/HP_bar2.png"):
		$HP/Sprite.texture = load("res://Image/HP_bar2.png")
	if $HP/Sprite2.scale.x > hp_rate:
		$HP/Sprite2.scale.x -= ($HP/Sprite2.scale.x-hp_rate)*delta*2
	if abs($HP/Sprite2.scale.x - hp_rate) < 0.001 and abs($HP/Sprite2.scale.x - hp_rate) > 0.0001:
		$HP/Sprite2.scale.x = hp_rate
	if shield == 0:
		$HP/Label.bbcode_text = "[right]" + String(hp) + "/" + String(max_hp) + "[/right]"
	else:
		$HP/Label.bbcode_text = "[right]" + String(hp) + "+[color=#0000E3]" + String(shield) + "[/color]/" + String(max_hp) + "[/right]"
	pass

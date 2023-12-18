extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum Card_types {attack, defand, function, curse}
enum Card_target_types {selftarget, all_target, enemy_target}

var card_index = [8, 9, 10, 3, 4, 5]
var card_discript = ["0", "0", "0", "0", "0", "0"]
var card_cost = [0, 0, 0, 0, 0, 0]
var card_image = ImageTexture
var card_frequency = [0, 0, 0, 0, 0, 0]
var card_power = [0, 0, 0, 0, 0, 0]
var card_type = [0,0,0,0,0,0]
var card_have_buff = [false, false, false, false, false, false]
var buff_type = [[ -1, -1, -1, -1, -1 ],[ -1, -1, -1, -1, -1 ],[ -1, -1, -1, -1, -1 ],[ -1, -1, -1, -1, -1 ],[ -1, -1, -1, -1, -1 ],[ -1, -1, -1, -1, -1 ]]
var card_target = [0,0,0,0,0,0]
var consume = [false, false, false, false, false, false]
var card_name = ["","","","","",""]
func _init():
	for i in card_datas.size():
		index_card_frequency.push_back(card_datas[i][0])
		index_card_target.push_back(card_datas[i][1])
		index_consume.push_back(card_datas[i][2])
		index_have_buff.push_back(card_datas[i][3])
		index_card_type.push_back(card_datas[i][4])
		index_buff_type.push_back(card_datas[i][5])
		index_card_cost.push_back(card_datas[i][6])
		index_card_power.push_back(card_datas[i][7])
		index_card_name.push_back(card_datas[i][8])
		index_card_sell.push_back(card_datas[i][9])
	

func new_index(index, pos):
	var temp
	if index >= 0:
		temp = index
	else:
		temp = -index-1
	card_index[pos] = index
	card_cost[pos] = index_card_cost[temp]
	card_type[pos] = index_card_type[temp]
	card_frequency[pos] = index_card_frequency[temp]
	card_power[pos] = index_card_power[temp]
	card_have_buff[pos] = index_have_buff[temp]
	buff_type[pos] = index_buff_type[temp]
	card_target[pos] = index_card_target[temp]
	consume[pos] = index_consume[temp]
	card_name[pos] = index_card_name[temp]

#----------------card data-----------------

var index_card_frequency = []
var index_card_target = []
var index_consume = []
var index_have_buff = []
var index_card_type = []
var index_buff_type = []
var index_card_cost = []
var index_card_power = []
var index_card_name = []
var index_card_discript_ = []
var index_card_sell = []

var card_datas = [
	#0
	[2,								#index_card_frequency
	Card_target_types.all_target,	#index_card_target
	false,							#index_consume
	false,							#index_have_buff
	Card_types.attack,				#index_card_type
	[ -1, -1, -1, -1, -1 ],			#index_buff_type
	0.5,							#index_card_cost
	3,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	],
	#1
	[1,								#index_card_frequency
	Card_target_types.all_target,	#index_card_target
	false,							#index_consume
	false,							#index_have_buff
	Card_types.attack,				#index_card_type
	[ -1, -1, -1, -1, -1 ],			#index_buff_type
	0.5,							#index_card_cost
	5,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	],
	#2
	[4,								#index_card_frequency
	Card_target_types.all_target,	#index_card_target
	false,							#index_consume
	false,							#index_have_buff
	Card_types.attack,				#index_card_type
	[ -1, -1, -1, -1, -1 ],			#index_buff_type
	1.5,							#index_card_cost
	3,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	],
	#3
	[1,								#index_card_frequency
	Card_target_types.all_target,	#index_card_target
	false,							#index_consume
	false,							#index_have_buff
	Card_types.attack,				#index_card_type
	[ -1, -1, -1, -1, -1 ],			#index_buff_type
	1.5,							#index_card_cost
	5,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	],
	#4
	[1,								#index_card_frequency
	Card_target_types.selftarget,	#index_card_target
	false,							#index_consume
	true,							#index_have_buff
	Card_types.function,				#index_card_type
	[ 0, -1, -1, -1, -1 ],			#index_buff_type
	0.5,							#index_card_cost
	0,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	],
	#5
	[1,								#index_card_frequency
	Card_target_types.selftarget,	#index_card_target
	true,							#index_consume
	true,							#index_have_buff
	Card_types.function,				#index_card_type
	[ 0, -1, -1, -1, -1 ],			#index_buff_type
	1.5,							#index_card_cost
	0,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	],
	#6
	[1,								#index_card_frequency
	Card_target_types.selftarget,	#index_card_target
	false,							#index_consume
	true,							#index_have_buff
	Card_types.function,				#index_card_type
	[ 1, -1, -1, -1, -1 ],			#index_buff_type
	2.0,							#index_card_cost
	0,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	],
	#7
	[1,								#index_card_frequency
	Card_target_types.selftarget,	#index_card_target
	false,							#index_consume
	true,							#index_have_buff
	Card_types.function,				#index_card_type
	[ 2, -1, -1, -1, -1 ],			#index_buff_type
	1.5,							#index_card_cost
	0,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	],
	#8
	[1,								#index_card_frequency
	Card_target_types.all_target,	#index_card_target
	false,							#index_consume
	false,							#index_have_buff
	Card_types.attack,				#index_card_type
	[ -1, -1, -1, -1, -1 ],			#index_buff_type
	1.0,							#index_card_cost
	0,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	],
	#9
	[1,								#index_card_frequency
	Card_target_types.selftarget,	#index_card_target
	false,							#index_consume
	false,							#index_have_buff
	Card_types.function,				#index_card_type
	[ -1, -1, -1, -1, -1 ],			#index_buff_type
	1.0,							#index_card_cost
	0,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	],
	#10
	[1,								#index_card_frequency
	Card_target_types.selftarget,	#index_card_target
	true,							#index_consume
	true,							#index_have_buff
	Card_types.function,				#index_card_type
	[ 3, -1, -1, -1, -1 ],			#index_buff_type
	0.5,							#index_card_cost
	0,								#index_card_power
	"",								#index_card_name
	20							#index_card_sell
	]
]
	
var battle
func index_card_discript():
	battle = get_parent().get_node("Battle")
	index_card_discript_ = [
	"[b]造成[color=green]" + String(index_card_power[0]*battle.multiple+battle.atk) + "[/color]傷害[color=green]2[/color]次[/b]",
	"[b]造成[color=green]" + String((index_card_power[1]+battle.atk_sum)*battle.multiple+battle.atk) + "[/color]傷害，本回合每造成一次傷害，本卡+1傷害[/b]",
	"[b]造成[color=green]" + String(index_card_power[2]*battle.multiple+battle.atk) + "[/color]傷害[color=green]4[/color]次[/b]",
	"[b]造成[color=green]" + String(index_card_power[3]+battle.get_node("Player").get_node("buff").buffs[0]*10*battle.multiple+battle.atk) + "[/color]傷害，清除所有[color=green]蓄勢[/color]，每清除一層蓄勢本卡傷害+[color=green]10[/color][/b]",
	"[b]獲得一層[color=green]蓄勢[/color][/b]",
	"[b]使[color=green]蓄勢[/color]層數翻倍，[color=red]消耗[/color][/b]",
	"[b]獲得一層[color=green]倍化[/color][/b]",
	"[b]獲得一層[color=green]攻擊擴散[/color][/b]",
	"[b]造成損失血量的傷害，血量低於25%時傷害翻倍[/b]",
	"[b]扣除目前血量的50%獲得扣除血量的護甲[/b]",
	"[b]獲得一層[color=green]復甦[/color]，[color=red]消耗[/color][/b]"
	]
	pass

onready var index_card_discript_2 = [
	"造成[color=green]" + String(index_card_power[0]) + "[/color]傷害[color=green]2[/color]次",
	"造成[color=green]" + String(index_card_power[1]) + "[/color]傷害，本回合每造成一次傷害，本卡+1傷害",
	"造成[color=green]" + String(index_card_power[2]) + "[/color]傷害[color=green]4[/color]次",
	"造成[color=green]" + String(index_card_power[3]) + "[/color]傷害，清除所有[color=green]蓄勢[/color]，每清除一層[color=green]蓄勢[/color]本卡傷害+[color=green]10[/color]",
	"獲得一層[color=green]蓄勢[/color]",
	"使[color=green]蓄勢[/color]層數翻倍，[color=red]消耗[/color]",
	"獲得一層[color=green]倍化[/color]",
	"獲得一層[color=green]攻擊擴散[/color]",
	"造成損失血量的傷害，血量低於25%時傷害翻倍",
	"扣除目前血量的50%獲得扣除血量的護甲",
	"獲得一層[color=green]復甦[/color]，[color=red]消耗[/color]"
	]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

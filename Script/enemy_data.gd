extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy_datas = [
	#0
	[4.0,	#speed
	1.0,	#wait_time
	4.0,	#first_attack_time
	[5, 15],	#attack_power
	[],		#start_buffs
	30,		#defand_power
	[[[act.attack],[act.curse],[act.heavy_attack]],
	[[act.curse],[act.heavy_attack],[act.attack]],
	[[act.attack],[act.curse],[act.heavy_attack]]],	#action_types
	50,		#max_hp
	"喽啰",		#enemy_name
	[[[[]],[[4,2.0]],[[]]],
	[[[4,2.0]],[[]],[[]]],
	[[[]],[[4,2.0]],[[]]]],			#use_buffs
	10								#heal_power
	],
	#1
	[4.0,	#speed
	1.0,	#wait_time
	4.0,	#first_attack_time
	[10, 20],	#attack_power
	[],		#start_buffs
	30,		#defand_power
	[[act.attack,act.attack,act.defand,act.heavy_attack],
	[act.attack,act.attack,act.defand,act.heavy_attack],
	[act.attack,act.attack,act.defand,act.heavy_attack]],	#action_types
	120,		#max_hp
	"",			#enemy_name
	[[[[]],[[]],[[]]],
	[[[]],[[]],[[]]],
	[[[]],[[]],[[]]]],			#use_buffs
	10								#heal_power
	],
	#2
	[4.0,	#speed
	1.0,	#wait_time
	4.0,	#first_attack_time
	[10, 20],	#attack_power
	[],		#start_buffs
	30,		#defand_power
	[[act.attack,act.attack,act.defand,act.heavy_attack],
	[act.attack,act.attack,act.defand,act.heavy_attack],
	[act.attack,act.attack,act.defand,act.heavy_attack]],	#action_types
	120,		#max_hp
	"",			#enemy_name
	[[[[]],[[]],[[]]],
	[[[]],[[]],[[]]],
	[[[]],[[]],[[]]]],			#use_buffs
	10								#heal_power
	],
]

var speed = []
var wait_time = []
var first_attack_time = []
var attack_power = []
var start_buffs = []
var defand_power = []
var action_types = []
var max_hp = []
var enemy_name = []
var use_buffs = []
var heal_power = []

func _init():
	for i in enemy_datas.size():
		speed.push_back(enemy_datas[i][0])
		wait_time.push_back(enemy_datas[i][1])
		first_attack_time.push_back(enemy_datas[i][2])
		attack_power.push_back(enemy_datas[i][3])
		start_buffs.push_back(enemy_datas[i][4])
		defand_power.push_back(enemy_datas[i][5])
		action_types.push_back(enemy_datas[i][6])
		max_hp.push_back(enemy_datas[i][7])
		enemy_name.push_back(enemy_datas[i][8])
		use_buffs.push_back(enemy_datas[i][9])
		heal_power.push_back(enemy_datas[i][10])

enum act {attack, defand, curse, heavy_attack, heal}
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

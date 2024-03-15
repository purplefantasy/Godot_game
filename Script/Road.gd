extends Node2D


var rates = [
	5.0,	#battle
	1.0,	#hard_battle
	2.0,	#treasure
	2.0,	#secret
	1.0		#shop
	]
var density = 2.0  #avg area time
enum road_event {
	battle,
	hard_battle,
	treasure,
	secret,
	shop,
	boss
	}
var road_event_icon = [
	preload("res://Image/icon_battle.png"),
	preload("res://Image/icon_hard_battle.png"),
	preload("res://Image/icon_treasure.png"),
	preload("res://Image/icon_secret.png"),
	preload("res://Image/icon_shop.png")]


var rng = RandomNumberGenerator.new()
onready var game = get_parent()
onready var clock_preview = get_parent().get_node("Clock_preview")
var time_road = []
var rate = 1000
var rates_sum = 0.0
var rates_final = []
var r
var r_road
var check = [1,0,0,0,0]
var all = false
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 5:
		rates_sum += rates[i]
	rates_final.push_back(rates[0] / rates_sum*100.0)
	rates_final.push_back((rates[0]+rates[1]) / rates_sum*100.0)
	rates_final.push_back((rates[0]+rates[1]+rates[2]) / rates_sum*100.0)
	rates_final.push_back((rates[0]+rates[1]+rates[2]+rates[3]) / rates_sum*100.0)
	rng.randomize()
	if density > 20.0:
		density = 20.0
	if density < 2.0:
		density = 2.0
	while !all:
		check = [1,0,0,0,0]
		time_road = []
		rate = 1000
		for i in 60:
			if i == 0:
				time_road.push_back(road_event.battle)
			else:
				r = rng.randi_range(1,1000)
				
				if r >= rate:
					r_road = rng.randi_range(1,100)
					if r_road <= rates_final[0]:
						r_road = road_event.battle
					if r_road <= rates_final[1] and r_road > rates_final[0]:
						r_road = road_event.hard_battle
					if r_road <= rates_final[2] and r_road > rates_final[1]:
						r_road = road_event.treasure
					if r_road <= rates_final[3] and r_road > rates_final[2]:
						r_road = road_event.secret
					if r_road > rates_final[3]:
						r_road = road_event.shop
					while r_road == time_road[i-1]:
						r_road = rng.randi_range(1,100)
						if r_road <= rates_final[0]:
							r_road = road_event.battle
						if r_road <= rates_final[1] and r_road > rates_final[0]:
							r_road = road_event.hard_battle
						if r_road <= rates_final[2] and r_road > rates_final[1]:
							r_road = road_event.treasure
						if r_road <= rates_final[3] and r_road > rates_final[2]:
							r_road = road_event.secret
						if r_road > rates_final[3]:
							r_road = road_event.shop
					time_road.push_back(r_road)
					check[r_road] += 1
					rate = 1000
				else:
					time_road.push_back(time_road[i-1])
					rate-=int(float(r)/((density-1)/2))
		all = true
		for i in 5:
			if check[i] == 0:
				all = false
	var first_pos
	var first_pos_set = false
	var road_pos
	var road_icon
	var icon_pos = 0
	for i in 60:
		if i > 0:
			if time_road[i] != time_road[i-1]:
				if !first_pos_set:
					first_pos = i
					first_pos_set = true
				icon_pos = float(icon_pos + i)/2
				road_pos = load("res://prefab/road_pos.tscn").instance()
				road_pos.transform[2].x = 288* cos(deg2rad(i*6-90.0))
				road_pos.transform[2].y = 288* sin(deg2rad(i*6-90.0))
				road_pos.rotation_degrees = i*6
				road_icon = load("res://prefab/road_icon.tscn").instance()
				road_icon.transform[2].x = 272* cos(deg2rad(icon_pos*6-90.0))
				road_icon.transform[2].y = 272* sin(deg2rad(icon_pos*6-90.0))
				if time_road[i-1] > 0:
					road_icon.texture = road_event_icon[time_road[i-1]]
				$second/road_icon.add_child(road_icon)
				$second/road_pos.add_child(road_pos)
				icon_pos = i
	if time_road[59] != 0:
		road_pos = load("res://prefab/road_pos.tscn").instance()
		road_pos.transform[2].x = 288* cos(deg2rad(-90.0))
		road_pos.transform[2].y = 288* sin(deg2rad(-90.0))
		$second/road_pos.add_child(road_pos)
		icon_pos = float(icon_pos + 60)/2
		road_icon = load("res://prefab/road_icon.tscn").instance()
		road_icon.transform[2].x = 272* cos(deg2rad(icon_pos*6-90.0))
		road_icon.transform[2].y = 272* sin(deg2rad(icon_pos*6-90.0))
		road_icon.texture = road_event_icon[time_road[59]]
	else:
		$second/road_icon.get_child(0).queue_free()
		icon_pos = float(icon_pos + first_pos + 60)/2
		print(icon_pos, " ",first_pos)
		road_icon = load("res://prefab/road_icon.tscn").instance()
		road_icon.transform[2].x = 272* cos(deg2rad(icon_pos*6-90.0))
		road_icon.transform[2].y = 272* sin(deg2rad(icon_pos*6-90.0))
		
	button_icon_change()
	$second/road_icon.add_child(road_icon)
	pass # Replace with function body.
	

func button_icon_change():
	road_count()
	$Button/Sprite.texture = road_event_icon[road_way[0]]
	$Button2/Sprite.texture = road_event_icon[road_way[1]]
	$Button3/Sprite.texture = road_event_icon[road_way[2]]

var old_visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if old_visible != visible:
		old_visible = visible
		clock_preview.visible = visible
		button_icon_change()
	pass
	get_node("second").get_node("secondhand").rotation_degrees = game.game_time*6
	get_node("minute").get_node("minutehand").rotation_degrees = game.game_time/10
	if visible:
		pass
	pass

onready var roads = [game.get_node("Battle"),game.get_node("Battle"),game.get_node("Treasure"),game.get_node("Secret"),game.get_node("Shop")]

var road_way = []
var road_time = []

func road_count():
	road_way = []
	road_time = []
	var temp_road = time_road[int(game.game_time) % 60]
	var temp_time = game.game_time
	road_way.push_back(temp_road)
	road_time.push_back(temp_time)
	var old_road_now = temp_road
	for i in range( int(temp_time)%60 , 60):
		if time_road[i] != temp_road:
			temp_road = time_road[i]
			temp_time+= i-int(temp_time)%60
			break
	if temp_road == old_road_now:
		for i in 60:
			if time_road[i] != temp_road:
				temp_road = time_road[i]
				temp_time+= 60-int(temp_time)%60+i
				break
	road_way.push_back(temp_road)
	road_time.push_back(temp_time)
	old_road_now = temp_road
	for i in range( int(temp_time)%60 , 60):
		if time_road[i] != temp_road:
			temp_road = time_road[i]
			temp_time+= i-int(temp_time)%60
			break
	if temp_road == old_road_now:
		for i in 60:
			if time_road[i] != temp_road:
				temp_road = time_road[i]
				temp_time+= 60-int(temp_time)%60+i
				break
	road_way.push_back(temp_road)
	road_time.push_back(temp_time)
	pass

func _on_Button_pressed():
	visible = false
	roads[road_way[0]].visible = true
	roads[road_way[0]].start()
	pass # Replace with function body.


func _on_Button2_pressed():
	
	game.game_time = road_time[1]
	visible = false
	roads[road_way[1]].visible = true
	roads[road_way[1]].start()
	pass # Replace with function body.


func _on_Button3_pressed():
	
	game.game_time = road_time[2]
	visible = false
	roads[road_way[2]].visible = true
	roads[road_way[2]].start()
	pass # Replace with function body.


func _on_Button4_pressed():
	if clock_preview.visible:
		clock_preview.visible = false
	else:
		clock_preview.visible = true
	pass # Replace with function body.

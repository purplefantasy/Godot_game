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
var road_pos_list = []
var mouse_area = -1
var area_chose = -1
var degree = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 60:
		degree.push_back(tan(i*6 * (PI / 180)))
	degree.push_back(0)
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
				road_pos_list.push_back(i)
				road_icon = load("res://prefab/road_icon.tscn").instance()
				road_icon.transform[2].x = 272* cos(deg2rad(icon_pos*6-90.0))
				road_icon.transform[2].y = 272* sin(deg2rad(icon_pos*6-90.0))
				if time_road[i-1] > 0:
					road_icon.texture = road_event_icon[time_road[i-1]]
				$second/road_icon.add_child(road_icon)
				$second/road_pos.add_child(road_pos)
				icon_pos = i
	road_pos_list.push_front(0)
	if time_road[59] != 0:
		road_pos_list.push_back(60)
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
		road_icon = load("res://prefab/road_icon.tscn").instance()
		road_icon.transform[2].x = 272* cos(deg2rad(icon_pos*6-90.0))
		road_icon.transform[2].y = 272* sin(deg2rad(icon_pos*6-90.0))
	
	$second/road_icon.add_child(road_icon)
	
	pass # Replace with function body.
	


var old_visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_mouse_area()
	if old_visible != visible:
		old_visible = visible
		area_chose = -1
		if !clock_preview.visible and clock_preview_visible or clock_preview.visible:
			clock_preview.visible = visible
	pass
	get_node("second").get_node("secondhand").rotation_degrees = game.game_time*6
	get_node("minute").get_node("minutehand").rotation_degrees = game.game_time/10
	if visible:
		if mouse_area >= 0 or area_chose >= 0:
			if mouse_area >= 0:
				for i in road_pos_list.size()-1:
					if road_pos_list[road_pos_list.size()-1] != 60 and i == 0:
						continue
					if mouse_area >= road_pos_list[i] and mouse_area < road_pos_list[i+1]:
						$second/secondhand_shadow.rotation_degrees = road_pos_list[i]*6
						$second/secondhand_shadow.visible = true
						break
				if road_pos_list[road_pos_list.size()-1] != 60:
					if mouse_area >= 0 and mouse_area < road_pos_list[1] or mouse_area >= road_pos_list[road_pos_list.size()-1]:
						$second/secondhand_shadow.rotation_degrees = road_pos_list[road_pos_list.size()-1]*6
						$second/secondhand_shadow.visible = true
			if area_chose >= 0 and mouse_area < 0:
				$second/secondhand_shadow.rotation_degrees = (area_chose)*6
		else:
			$second/secondhand_shadow.visible = false
		if area_chose >= 0:
			$Enter_road_button_icon.texture = road_event_icon[time_road[area_chose]]
		else:
			$Enter_road_button_icon.texture = road_event_icon[time_road[int(game.game_time)%60]]
	pass

onready var roads = [game.get_node("Battle"),game.get_node("Battle"),game.get_node("Treasure"),game.get_node("Secret"),game.get_node("Shop")]

var road_time = []



var clock_preview_visible = true


var mouse_x = 0
var mouse_y = 0
var in_range = false

func _input(event):
	if event is InputEventMouse:
		mouse_x = event.position.x
		mouse_y = event.position.y
	pass



func get_mouse_area():
	if  pow(mouse_x-$second.transform[2].x,2) + pow(mouse_y-$second.transform[2].y,2) < pow(256*1.5,2):
		var mouse_slope
		if  ($second.transform[2].y-mouse_y) != 0:
			mouse_slope = ((mouse_x-$second.transform[2].x) / ($second.transform[2].y-mouse_y))
		else:
			mouse_slope = ((mouse_x-$second.transform[2].x) / -0.01)
		if mouse_x-$second.transform[2].x > 0 and $second.transform[2].y-mouse_y > 0:
			for i in 15:
				if mouse_slope >= degree[i]:
					mouse_area = i
		elif mouse_x-$second.transform[2].x > 0 and $second.transform[2].y-mouse_y < 0:
			for i in 15:
				if mouse_slope < degree[i+16]:
					mouse_area = i+15
					break
		elif mouse_x-$second.transform[2].x < 0 and $second.transform[2].y-mouse_y < 0:
			for i in 15:
				if mouse_slope >= degree[i+30]:
					mouse_area = i+30
		elif mouse_x-$second.transform[2].x < 0 and $second.transform[2].y-mouse_y > 0:
			for i in 15:
				if mouse_slope < degree[i+46]:
					mouse_area = i+45
					break
	else:
		mouse_area = -1

	

func _on_Clock_Button_button_down():
	if  pow(mouse_x-$second.transform[2].x,2) + pow(mouse_y-$second.transform[2].y,2) < pow(512,2):
		in_range = true
	pass # Replace with function body.


func _on_Clock_Button_button_up():
	if pow(mouse_x-$second.transform[2].x,2) + pow(mouse_y-$second.transform[2].y,2) < pow(512,2) and in_range:
		for i in road_pos_list.size()-1:
			if road_pos_list[road_pos_list.size()-1] != 60 and i == 0:
				continue
			if mouse_area >= road_pos_list[i] and mouse_area < road_pos_list[i+1]:
				area_chose = road_pos_list[i]
		if road_pos_list[road_pos_list.size()-1] != 60:
			if mouse_area >= 0 and mouse_area < road_pos_list[1] or mouse_area >= road_pos_list[road_pos_list.size()-1]:
				area_chose = road_pos_list[road_pos_list.size()-1]
	in_range = false
	pass # Replace with function body.


func _on_Clock_priview_button_pressed():
	if clock_preview_visible:
		clock_preview_visible = false
		clock_preview.visible = false
	else:
		clock_preview_visible = true
		clock_preview.visible = true
	pass # Replace with function body.


func _on_Enter_road_button_pressed():
	if int(game.game_time) % 60 < area_chose:
		game.game_time = int(game.game_time) / 60 * 60 + area_chose
	else:
		if area_chose != -1:
			game.game_time = int(game.game_time) / 60 * 60 + area_chose + 60
	if area_chose > 0 :
		visible = false
		roads[time_road[area_chose]].visible = true
		roads[time_road[area_chose]].start()
	else:
		visible = false
		roads[time_road[int(game.game_time)%60]].visible = true
		roads[time_road[int(game.game_time)%60]].start()
	pass # Replace with function body.

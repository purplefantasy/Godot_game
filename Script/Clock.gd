extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var game = get_parent().get_parent()
var timer = 0.0
var old_timer_floor = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
onready var root = get_parent()
onready var target_buffs = [get_parent().get_node("Enemy/buff"),get_parent().get_node("Enemy2/buff"),get_parent().get_node("Enemy3/buff"),get_parent().get_node("Player/buff")]
onready var buff_data = get_parent().get_parent().get_node("Buff_data")

var mouse_x
var mouse_y
var in_range = false
var look_clock = false
onready var old_y = transform[2].y
var clock_return = true

func _input(event):
	if event is InputEventMouseButton:
		mouse_x = event.position.x
		mouse_y = event.position.y
	pass

func restart():
	timer = game.game_time
	old_timer_floor = floor(timer)
	rotation_degrees = -timer*6
	for i in 3:
		get_child(i).visible = true
		get_child(i).modulate.a = 1.0
		get_child(i).change_time()

func add_time(num):
	timer += num
	for i in 4:
		for j in buff_data.buff_name.size():
			if buff_data.index_time_reduce[j]:
				target_buffs[i].buff_add(j, -num)
	for i in 3:
		root.enemy[i].turn_time -= num
		if root.enemy[i].turn_time < 0 and root.enemy[i].alive:
			root.player_turn = false
			root.enemy[i].action = true
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if look_clock: 
		if rotation_degrees != -180:
			rotation_degrees -= (rotation_degrees-180) * delta *3
			if abs(rotation_degrees - 180) < 0.1:
				rotation_degrees = 180
		if 540 - transform[2].y > 0.1:
			transform[2].y += (540 - transform[2].y)* delta*5
		else:
			transform[2].y = 540
	else:
		if rotation_degrees != -timer*6 and !clock_return:
			rotation_degrees -= (rotation_degrees-int(-timer*6)%360 + int(timer*6)-timer*6) * delta *3
			if abs(rotation_degrees+timer*6) < 0.1:
				rotation_degrees = -timer*6
		if old_y != transform[2].y:
			get_node("Button").rect_scale.x = 1
			get_node("Button").rect_scale.y = 1
			if transform[2].y-old_y > 0.5:
				transform[2].y += (old_y - transform[2].y)* delta*5
			else:
				clock_return = true
				z_index = 0
				transform[2].y = old_y
	if clock_return and get_child(0).modulate.a < 1:
		for i in 3:
			get_child(i).modulate.a += delta*2
			if get_child(i).modulate.a > 1:
				get_child(i).modulate.a = 1
	if old_timer_floor != floor(timer):
		if root.player_class == 0:
			root.get_node("Player").get_node("buff").buff_add(0, floor(timer) - old_timer_floor)
		old_timer_floor = floor(timer)
		root.use_card = true
	if abs(rotation_degrees+timer*6) > 6 and clock_return:
		rotation_degrees -= delta*(rotation_degrees+timer*6)*2.5
	if abs(get_node("Secondhand").rotation_degrees-180-timer*6) > 6:
		get_node("Secondhand").rotation_degrees -= delta*(get_node("Secondhand").rotation_degrees-180-timer*6)*2.5
	if abs(rotation_degrees+timer*6) <= 6 and clock_return:
		rotation_degrees -= delta*(rotation_degrees+timer*6)
	if abs(get_node("Secondhand").rotation_degrees-180-timer*6) <= 6:
		get_node("Secondhand").rotation_degrees -= delta*(get_node("Secondhand").rotation_degrees-180-timer*6)
	if abs(rotation_degrees+timer*6)<0.05 and clock_return:
		rotation_degrees = -timer*6
	if abs(get_node("Secondhand").rotation_degrees-timer*6) < 0.05:
		get_node("Secondhand").rotation_degrees = timer*6 + 180
	pass



func _on_Button_button_down():
	if  pow(mouse_x-transform[2].x,2) + pow(mouse_y-transform[2].y,2) < pow(512,2) and !look_clock:
		in_range = true
	pass # Replace with function body.


func _on_Button_button_up():
	if pow(mouse_x-transform[2].x,2) + pow(mouse_y-transform[2].y,2) < pow(512,2) and in_range:
		if look_clock:
			look_clock = false
		else:
			clock_return = false
			look_clock = true
			get_node("Button").rect_scale.x = 3
			get_node("Button").rect_scale.y = 3
			for i in 3:
				get_child(i).modulate.a = 0
			z_index = 10
	else:
		if look_clock:
			look_clock = false
	in_range = false
	pass # Replace with function body.

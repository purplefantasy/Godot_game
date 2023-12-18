extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buffs = []

	
	
onready var buff_data = get_parent().get_parent().get_parent().get_node("Buff_data")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in buff_data.buff_name.size():
		buffs.push_back(0)
	pass # Replace with function body.

func restart():
	for i in buff_data.buff_name.size():
		buff_reset(i)

var buff_list = []



func buff_add(index, num):
	var buff_num_change = true
	for i in buff_list.size():
		if buff_list[i] == index:
			buff_num_change = false
	if buffs[index] == 0 and num <= 0:
		buff_num_change = false
	else:
		buffs[index] += num
	if buff_num_change:
		buff_list.push_front(index)
	if buffs[index] <= 0:
		buff_reset(index)
	else:
		load_buff(index,buff_num_change)
	
func buff_reset(index):
	buffs[index] = 0
	var reset_index = -1
	for i in buff_list.size():
		if buff_list[i] == index:
			reset_index = i
	if reset_index >= 0:
		for i in buff_list.size() - reset_index -1:
			buff_list[i+reset_index] = buff_list[i+reset_index+1] 
		buff_list.pop_back()
		load_buff(index, true)

func load_buff(index, buff_num_change):
	if buff_num_change:
		for i in get_child_count()-2:
			get_child(i+2).queue_free()
		for i in buff_list.size():
			if i > 0:
				var buff_shadow = load("res://prefab/buff_shadow.tscn").instance()
				buff_shadow.get_child(0).text = String(buffs[buff_list[i]])
				buff_shadow.transform[2].x = 50*i
				buff_shadow.transform[2].y = 0
				add_child(buff_shadow)
			else:
				visible = true
				$Label.text = String(buffs[buff_list[0]])
		if buff_list.size() == 0:
			visible = false
	else:
		for i in buff_list.size()-1:
			if buff_list[i+1] == index:
				get_child(i+2).get_child(0).text = String(buffs[index])
		if buff_list != []:
			$Label.text = String(buffs[buff_list[0]])
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	
	
	pass


func _on_Control_mouse_entered():
	pass # Replace with function body.


func _on_Control_mouse_exited():
	pass # Replace with function body.

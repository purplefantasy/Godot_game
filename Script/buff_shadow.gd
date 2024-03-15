extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var buff_data = get_parent().get_parent().get_parent().get_parent().get_node("Buff_data")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Control/Buff_discript_box/Sprite").scale.x = get_node("Control/Buff_discript_box/Label").rect_size.x / 32.0 +0.1
	pass

var mouse_event

func _input(event):
	if event is InputEventMouse:
		mouse_event=event
	pass

func _on_Control_mouse_entered():
	get_node("Control/Buff_discript_box/Label").text = buff_data.buff_name[get_parent().buff_list[get_index()-1]]
	get_node("Control/Buff_discript_box").transform[2].x = mouse_event.position.x-get_global_transform()[2].x+20
	get_node("Control/Buff_discript_box").transform[2].y = mouse_event.position.y-get_global_transform()[2].y+20
	get_node("Control/Buff_discript_box").visible = true
	pass # Replace with function body.


func _on_Control_mouse_exited():
	get_node("Control/Buff_discript_box").transform[2].x = 10000
	get_node("Control/Buff_discript_box").transform[2].y = 10000
	get_node("Control/Buff_discript_box").visible = false
	pass # Replace with function body.

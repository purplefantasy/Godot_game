extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var class_data = get_parent().get_node("Class_data")
var menus = ["start","load", "cards","setting", "quit"]
var menu_button
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in menus.size():
			menu_button = load("res://prefab/main_menu_button.tscn").instance()
			menu_button.transform[2].x = 960
			menu_button.transform[2].y = 540 + (i-menus.size()/2)*100
			menu_button.get_node("Label").text = menus[i]
			get_node("main_menu_button").add_child(menu_button)
	class_select(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_node("Select_class").visible = false
	get_node("main_menu_button").visible = true
	pass # Replace with function body.


func _on_Start_pressed():
	visible = false
	
	get_node("Select_class").visible = false
	get_node("main_menu_button").visible = true
	get_parent().get_node("Road").visible = true
	get_parent().get_node("Clock_preview").visible = true
	class_select(0)

var selected_class = 0 

func class_select(index):
	get_node("Select_class/Class_discript/RichTextLabel").bbcode_text = class_data.class_discript[index]
	get_node("Select_class/Class_discript/RichTextLabel2").bbcode_text = class_data.class_skill[index]
	var class_num = get_child_count()
	for i in class_num:
		get_node("Select_class/Class_image").get_child(i).get_node("Select_class").visible = false
	get_node("Select_class/Class_image").get_child(index).get_node("Select_class").visible = true
	pass

func _on_class_pressed():
	selected_class = 0 
	class_select(0)
	pass # Replace with function body.


func _on_class2_pressed():
	selected_class = 1
	class_select(1)
	pass # Replace with function body.


func _on_class3_pressed():
	selected_class = 2
	class_select(2)
	pass # Replace with function body.

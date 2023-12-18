extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

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

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
onready var game = get_parent()
onready var road = game.get_node("Road")

func start():
	pass

func _on_Button_pressed():
	game.game_time += 10.0
	visible = false
	road.visible = true
	pass # Replace with function body.

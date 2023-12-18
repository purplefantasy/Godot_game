extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

onready var root = get_parent()

func _on_Button_pressed():
	root.get_node("Gray_window").visible = true
	root.get_node("Gray_window").view = 5
	pass # Replace with function body.

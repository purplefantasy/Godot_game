extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var class_index = get_index()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_class_pressed():
	get_node("Select_class").visible = true
	pass # Replace with function body.

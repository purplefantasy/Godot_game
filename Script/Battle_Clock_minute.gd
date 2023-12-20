extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var clock = get_parent().get_node("Clock")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform[2].x = clock.transform[2].x - 550
	transform[2].y = clock.transform[2].y - 300
	get_node("Battle_minutehand").rotation_degrees = clock.timer/10
	pass

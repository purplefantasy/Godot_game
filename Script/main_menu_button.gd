extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.rect_size.x = 52.0 + $Label.rect_size.x/4
	transform[2].x -= 52.0 + $Label.rect_size.x/4
	transform[2].y -= $Button.rect_size.y/2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	if get_index() == 0:
		get_parent().visible = false
		get_parent().get_parent().get_node("Select_class").visible = true
	if get_index() == 4:
		get_tree().quit()
	pass # Replace with function body.

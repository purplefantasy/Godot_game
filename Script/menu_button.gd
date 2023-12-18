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
	if get_index() == 1:
		get_parent().view = 7
	if get_index() == 2:
		get_parent().switch_visible()
		get_parent().get_parent().visible = false
		get_parent().get_parent().restart()
		get_tree().current_scene.get_node("Main_menu").visible = true
	pass # Replace with function body.

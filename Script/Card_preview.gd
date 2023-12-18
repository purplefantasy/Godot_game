extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	transform_old = [transform[2].x, transform[2].y]
	pass # Replace with function body.

var transform_old
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !$".".get_parent().card_detail:
		transform[2].x = transform_old[0]
		transform[2].y = transform_old[1]
		scale.x = 1
		scale.y = 1
		z_index = 0
	pass

func _on_Button_pressed():
	if !$".".get_parent().card_detail:
		$".".get_parent().card_detail = true
		transform_old = [transform[2].x, transform[2].y]
		transform[2].x = 960
		transform[2].y = 540
		scale.x = 2
		scale.y = 2
		z_index = 1
	else:
		$".".get_parent().card_detail = false
	pass # Replace with function body.

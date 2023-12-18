extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var anime_speed = 16
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var old_x = transform[2].x
onready var old_y = transform[2].y
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !$".".get_parent().card_detail:
		select = false
		get_node("Button").rect_scale.x = 1
		get_node("Button").rect_scale.y = 1
	if select and scale.x < 3:
		transform[2].x += (960-transform[2].x)*delta*anime_speed
		transform[2].y += (540-transform[2].y)*delta*anime_speed
		scale.x += delta*anime_speed*0.4
		scale.y += delta*anime_speed*0.4
		if scale.x > 3:
			scale.x = 3
			scale.y = 3
	if !select and scale.x > 1:
		transform[2].x += (old_x-transform[2].x)*delta*anime_speed
		transform[2].y += (old_y-transform[2].y)*delta*anime_speed
		scale.x -= delta*anime_speed*0.4
		scale.y -= delta*anime_speed*0.4
		if scale.x < 1:
			scale.x = 1
			scale.y = 1
			z_index = 0

var select = false

func _on_Button_pressed():
	if select:
		select = false
		get_node("Button").rect_scale.x = 1
		get_node("Button").rect_scale.y = 1
		$".".get_parent().card_detail = false
	else:
		if !$".".get_parent().card_detail:
			z_index = 1
			select = true
			get_node("Button").rect_scale.x = 20
			get_node("Button").rect_scale.y = 10
			$".".get_parent().card_detail =true
		else:
			$".".get_parent().card_detail =false
	pass # Replace with function body.

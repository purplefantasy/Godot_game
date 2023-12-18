extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var battle = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	scale.x = 0.5
	scale.y = 0.5
	transform[2].x = 260* cos(deg2rad(90.0+float(get_parent().get_parent().get_child(index).real_turn_time *6)))
	transform[2].y = 260* sin(deg2rad(90.0+float(get_parent().get_parent().get_child(index).real_turn_time *6)))
	pass # Replace with function body.


onready var clock = get_parent()
onready var index = get_index()

func change_time():
	transform[2].x = 260* cos(deg2rad(90.0+float(get_parent().get_parent().get_child(index).real_turn_time *6)))
	transform[2].y = 260* sin(deg2rad(90.0+float(get_parent().get_parent().get_child(index).real_turn_time *6)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$".".global_rotation_degrees = get_parent().rotation_degrees + battle.get_child(index).real_turn_time *6
	$Label.set_global_position( Vector2(get_global_transform()[2].x - 30*cos(deg2rad(global_rotation_degrees)) - 10*sin(deg2rad(global_rotation_degrees)) , get_global_transform()[2].y+ 10*cos(deg2rad(global_rotation_degrees)) - 30*sin(deg2rad(global_rotation_degrees))))
	$Label.rect_rotation = - global_rotation_degrees
	$Label.text = String(get_parent().get_parent().get_child(get_index()).old_turn_time) + "s"
	if !battle.enemy[index].alive:
		modulate.a -= delta
		if delta <= 0.0:
			visible = false
			modulate.a = 0
	pass

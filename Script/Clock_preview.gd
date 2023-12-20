extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var road = get_parent().get_node("Road")
var time_road = []
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

var rotation_angle = 50
var angle_from = 0
var angle_to = 0
func draw_circle_arc_poly(x, y, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(Vector2(x, y))
	var colors = PoolColorArray([color])
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(Vector2(x, y) + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

var colors = [Color(0, 0, 1, 0.5),Color(1, 0, 0, 0.5),Color(1, 0.843137, 0,0.5),Color(0.627451, 0.12549, 0.941176, 0.5),Color(1, 1, 1, 0.5)]

func _draw():
	var radius = 372
	var color
	angle_from = 0
	angle_to = 0
	if time_road != []:
		for i in time_road.size():
			if time_road[i] != time_road[i-1]:
				color = colors[time_road[i-1]]
				angle_to = i*6
				draw_circle_arc_poly( road.get_node("second").transform[2].x, road.get_node("second").transform[2].y, radius, angle_from, angle_to, color )
				angle_from = i*6
		angle_to = 360
		color = colors[time_road[59]]
		draw_circle_arc_poly( road.get_node("second").transform[2].x, road.get_node("second").transform[2].y, radius, angle_from, angle_to, color )
	pass
	
var draw = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# We only wrap angles when both of them are bigger than 360.
	if road.time_road != [] and !draw:
		time_road += road.time_road
		update()
		draw = true
		
	pass

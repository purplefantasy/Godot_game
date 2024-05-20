extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var road = get_parent().get_node("Road")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
var mouse_area
var rotation_angle = 50
var time_road = []
var angle_from = 0
var angle_to = 0
func draw_circle_arc_poly(x, y, radius, radius2, angle_from, angle_to, color, max_radius):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(Vector2(x+radius2*cos(deg2rad(angle_to-90)), y+radius2*sin(deg2rad(angle_to-90))))
	points_arc.push_back(Vector2(x+radius2*cos(deg2rad(angle_from-90)), y+radius2*sin(deg2rad(angle_from-90))))
	var colors = PoolColorArray([color])
	if radius == max_radius:
		for i in range(nb_points + 1):
			var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
			points_arc.push_back(Vector2(x, y) + Vector2(cos(angle_point), sin(angle_point)) * radius)
	else:
		points_arc.push_back(Vector2(x+radius*cos(deg2rad(angle_from-90)), y+radius*sin(deg2rad(angle_from-90))))
		points_arc.push_back(Vector2(x+radius*cos(deg2rad(angle_to-90)), y+radius*sin(deg2rad(angle_to-90))))
	draw_polygon(points_arc, colors)

func draw_clock(x, y, radius, angle_from, angle_to, color):
	var chip = 100
	color.push_back(0.007)
	for i in chip:
		color[3] = 0.007 * i
		draw_circle_arc_poly(x, y, radius*(chip-i)/chip, radius*(chip-i-1)/chip, angle_from, angle_to, Color(color[0],color[1],color[2],color[3]), radius)
	pass

var colors = [[0.0, 0.0, 1.0],[1.0, 0.0, 0.0],[1.0, 0.843137,0.0],[0.627451, 0.12549, 0.941176],[1, 1, 1], 
			[0, 0, 0.9],[0.9, 0, 0],[0.7, 0.543137, 0],[0.427451, 0, 0.741176],[0.6, 0.6, 0.6]]

var road_pos = []
var road_pos_list = []
func _draw():
	var radius = 372
	var color
	angle_from = 0
	angle_to = 0
	if road_pos_list != []:
		for i in road_pos_list.size()-1:
			if road_pos_list[road_pos_list.size()-1] != 60 and i == 0:
				angle_from = road_pos_list[i+1]*6
				continue
			color = colors[time_road[road_pos_list[i]]]
			angle_to = road_pos_list[i+1]*6
				
			draw_clock( road.get_node("second").transform[2].x, road.get_node("second").transform[2].y, radius, angle_from, angle_to, color )
			if mouse_area >= road_pos_list[i] and mouse_area < road_pos_list[i+1]:
				color = colors[time_road[road_pos_list[i]]+5]
				draw_clock( road.get_node("second").transform[2].x, road.get_node("second").transform[2].y-2, radius, angle_from, angle_to, color )
			angle_from = road_pos_list[i+1]*6
		if road_pos_list[road_pos_list.size()-1] != 60:
			angle_to = 0
			angle_from = road_pos_list[1]*6
			color = colors[time_road[59]]
			draw_clock( road.get_node("second").transform[2].x, road.get_node("second").transform[2].y, radius, angle_from, angle_to, color )
			angle_to = 360
			angle_from = road_pos_list[road_pos_list.size()-1]*6
			draw_clock( road.get_node("second").transform[2].x, road.get_node("second").transform[2].y, radius, angle_from, angle_to, color )
			if mouse_area >= 0 and mouse_area < road_pos_list[1] or mouse_area >= road_pos_list[road_pos_list.size()-1]:
				color = colors[time_road[road_pos_list[road_pos_list.size()-1]]+5]
				draw_clock( road.get_node("second").transform[2].x, road.get_node("second").transform[2].y-2, radius, angle_from, angle_to, color )
				angle_to = 0
				angle_from = road_pos_list[1]*6
				draw_clock( road.get_node("second").transform[2].x, road.get_node("second").transform[2].y-2, radius, angle_from, angle_to, color )
	pass
	
var draw = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# We only wrap angles when both of them are bigger than 360.
	mouse_area = road.mouse_area
	time_road = road.time_road
	road_pos_list = road.road_pos_list
	update()
		#draw = true
		
	pass

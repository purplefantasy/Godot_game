extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	rdx = rng.randf_range(-32.0,32.0)
	rdy = rng.randf_range(-96.0,-64.0)
	pass # Replace with function body.
var rng
var rdx
var rdy
var speed = 6.0
var max_time = 1.2



var g = 150
var timer = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !get_parent().get_parent().pause:
		modulate.a -= delta*0.5
		if modulate.a <= 0:
			queue_free()
		timer += delta
		if timer < max_time:
			$".".transform[2].x += rdx*delta*speed
			rdy += g*delta
			$".".transform[2].y += rdy*delta*speed
	
	pass

extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var useX
var useY
var consume = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	modulate.a -= delta
	if modulate.a <= 0:
		queue_free()
	if consume:
		useX = transform[2].x
		useY = transform[2].y
	transform[2].x -= delta*(transform[2].x-useX)*5
	transform[2].y -= delta*(transform[2].y-useY)*5
	pass

extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cards = []
var rng = RandomNumberGenerator.new()
onready var battle = get_parent()
var rng_seed
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	rng_seed = rng.seed
	pass # Replace with function body.

func start():
	cards = []

func restart():
	cards = []
	rng = RandomNumberGenerator.new()
	rng.seed = rng_seed

func use_card(index):
	cards.push_back(index)
	pass

func shuffle():
	var temp
	var r
	for i in cards.size():
		r = rng.randi_range(0,cards.size()-1)
		temp = cards[i]
		cards[i] = cards[r]
		cards[r] = temp
	pass

func draw_card():
	shuffle()
	var temp = cards
	cards = []
	return temp
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Button_pressed():
	battle.get_node("Gray_window").visible = true
	battle.get_node("Gray_window").view = 3
	pass # Replace with function body.

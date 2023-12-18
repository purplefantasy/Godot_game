extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cards = [0,1,2,3,4,5,6,7,8,9,10]
var old_cards = []



# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	shuffle()
	old_cards += cards
	pass # Replace with function body.

func restart():
	cards = []
	cards += old_cards

onready var battle = get_parent()

func draw_card():
	return pop()

func pop():
	var temp = cards.pop_front()
	if cards == []:
		cards = battle.get_node("Used_deck").draw_card()
	return temp

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var rng = RandomNumberGenerator.new()


func shuffle():
	var temp
	var r
	for i in cards.size():
		r = rng.randi_range(0,cards.size()-1)
		temp = cards[i]
		cards[i] = cards[r]
		cards[r] = temp
	pass

func _on_Button_pressed():
	battle.get_node("Gray_window").visible = true
	battle.get_node("Gray_window").view = 1
	pass # Replace with function body.

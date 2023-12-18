extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var select = 0
var card_detail = false
onready var card_data = get_parent().get_node("Card_data")
onready var player_deck = get_parent().get_node("Player_deck")
onready var road = get_parent().get_node("Road")
onready var card = [$Card_detail,$Card_detail2,$Card_detail3]
var rng = RandomNumberGenerator.new()
var r
var card_index = []
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for i in 3:
		r = rng.randi_range(0,card_data.index_card_name.size()-1)
		card[i].get_child(0).bbcode_text = card_data.index_card_discript_2[r]
		card_index.push_back(r)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func reward_end():
	visible = false
	road.visible = true
	pass


func _on_select1_pressed():
	select = 1
	pass # Replace with function body.


func _on_select2_pressed():
	select = 2
	pass # Replace with function body.


func _on_select3_pressed():
	select = 3
	pass # Replace with function body.


func _on_confirm_pressed():
	if select > 0:
		player_deck.cards.push_back(card_index[select-1])
		reward_end()
	else:
		pass
	pass # Replace with function body.


func _on_skip_pressed():
	reward_end()
	pass # Replace with function body.

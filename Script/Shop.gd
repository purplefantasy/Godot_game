extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()
onready var card_data = get_parent().get_node("Card_data")
onready var player_deck = get_parent().get_node("Player_deck")
onready var game = get_parent()
onready var road = get_parent().get_node("Road")

var r
var shop_slot = []
var shop_card
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for i in 10:
		r = rng.randi_range(0,card_data.index_card_name.size()-1)
		shop_slot.push_back(r)
		shop_card = load("res://prefab/Shop_card.tscn").instance()
		shop_card.transform[2].x = 300 + (i%5) * 200
		shop_card.transform[2].y = 200 + (i/5) * 400
		shop_card.card_index = r
		get_node("Shop_cards").add_child(shop_card)
	
	pass # Replace with function body.

func start():
	rng.randomize()
	shop_slot = []
	for i in 10:
		r = rng.randi_range(0,card_data.index_card_name.size()-1)
		shop_slot.push_back(r)
		get_node("Shop_cards").get_child(i).new_index(r)

func buy_card(index, cost):
	player_deck.cards.push_back(index)
	game.game_time += cost
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Leave_pressed():
	game.game_time += 5.0
	road.visible = true
	visible = false
	pass # Replace with function body.

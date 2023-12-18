extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var card_data = get_parent().get_parent().get_parent().get_node("Card_data")
var card_index

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("RichTextLabel").bbcode_text = card_data.index_card_discript_2[card_index]
	get_node("Button").text = String(card_data.index_card_sell[card_index]) + "s"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func new_index(index):
	card_index = index
	get_node("RichTextLabel").bbcode_text = card_data.index_card_discript_2[card_index]
	get_node("Button").text = String(card_data.index_card_sell[card_index]) + "s"
	
	texture = load("res://Image/card.png")
	for i in 2:
		get_child(i).visible = true
	get_node("Button").disabled = false

func _on_Button_pressed():
	texture = load("res://Image/card_sold.png")
	for i in 2:
		get_child(i).visible = false
	get_node("Button").disabled = true
	get_node("Button").text = "售出"
	get_parent().get_parent().buy_card(card_index,card_data.index_card_sell[card_index])
	pass # Replace with function body.

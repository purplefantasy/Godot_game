extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var show_card = false
var cards = []
onready var battle = get_parent()
var view = 0

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		switch_visible()
	if event is InputEventMouseButton:
		if event.button_index == 4:
			#print("MOUSE_BUTTON_WHEEL_UP")
			event.button_index = 0
		if event.button_index == 5:
			#print("MOUSE_BUTTON_WHEEL_DOWN")
			event.button_index = 0
	pass

func swap(a):
	var temp
	temp = cards[a]
	cards[a] = cards[a+1]
	cards[a+1] = temp
	pass

func sort():
	for i in cards.size()-1:
		for j in i+1:
			if cards[i-j] > cards[i-j+1]:
				swap(i-j)
	pass
	
onready var restart_image = get_parent().get_node("restart_image")
var card_preview
var card_detail = false
onready var card_data = get_parent().get_parent().get_node("Card_data")
var menu_button
var menus = ["restart", "save and quit"]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if view == 1:
		battle.pause = true
		cards = []
		cards += battle.get_node("Deck").cards
		sort()
		for i in cards.size():
			card_preview = load("res://prefab/Card_preview.tscn").instance()
			card_preview.transform[2].x = 200+(i%10)*180
			card_preview.transform[2].y = 200+(floor(i/10))*300
			card_preview.get_child(0).bbcode_text = card_data.index_card_discript_2[cards[i]]
			add_child(card_preview)
		view = 2
	if view == 3:
		battle.pause = true
		cards = []
		cards += battle.get_node("Used_deck").cards
		sort()
		for i in cards.size():
			card_preview = load("res://prefab/Card_preview.tscn").instance()
			card_preview.transform[2].x = 200+(i%10)*180
			card_preview.transform[2].y = 200+(floor(i/10))*300
			card_preview.get_child(0).bbcode_text = card_data.index_card_discript_2[cards[i]]
			add_child(card_preview)
		view = 2
	if view == 5:
		battle.pause = true
		for i in menus.size():
			menu_button = load("res://prefab/menu_button.tscn").instance()
			menu_button.transform[2].x = 960
			menu_button.transform[2].y = 540 + (i-menus.size()/2)*100
			menu_button.get_child(0).text = menus[i]
			add_child(menu_button)
		view = 4
	if view == 8:
		restart_image.transform[2].y += 3240.0 * delta
		if (restart_image.transform[2].y > 1080.0):
			restart_image.transform[2].y = -2160.0
			view = 0
	if view == 7:
		restart_image.transform[2].y += 3240.0 * delta
		if (restart_image.transform[2].y > -540.0):
			for i in menus.size():
				get_child(i+1).queue_free()
			visible = false
			battle.pause = false
			battle.clear()
			restart()
			view = 8
	pass

func switch_visible():
	if get_parent().visible:
		if visible:
			if card_detail:
				card_detail = false
			else:
				battle.pause = false
				if view == 2:
					for i in cards.size():
						get_child(i+1).queue_free()
				if view == 4:
					for i in menus.size():
						get_child(i+1).queue_free()
				visible = false
		else:
			visible = true
			view = 5

func restart():
	battle.restart()
	

func _on_Button_pressed():
	switch_visible()
	pass # Replace with function body.

extends Sprite


var mouse_press = false
var moving = false
var mouse_event
onready var oldX = transform[2].x
onready var oldY = transform[2].y
# Called when the node enters the scene tree for the first time.
onready var battle = get_parent()
onready var enemys = [battle.get_node("Enemy"),battle.get_node("Enemy2"),battle.get_node("Enemy3")]
onready var player = battle.get_node("Player")
var card_target = -1
onready var card_data = get_parent().get_parent().get_node("Card_data")
onready var card_pos = get_index()-4

func _ready():
	moving = true
	transform[2].x = battle.get_node("Deck").transform[2].x
	transform[2].y = battle.get_node("Deck").transform[2].y
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.get_node("buff").buffs[0] > 0 and battle.card_data.card_type[card_pos] == 0 and battle.card_data.card_index[card_pos] != 3:
		$RichTextLabel2.bbcode_text = "X" + String(player.get_node("buff").buffs[0]+1)
	else:
		$RichTextLabel2.bbcode_text = ""
	if mouse_press:
		transform[2].x = mouse_event.position.x
		transform[2].y = mouse_event.position.y
	if moving and !mouse_press:
		transform[2].x -= delta*(transform[2].x-oldX)*5
		transform[2].y -= delta*(transform[2].y-oldY)*5
	if abs(transform[2].x-oldX) < 1 and abs(transform[2].y-oldY) < 1 and moving:
		transform[2].x =oldX
		transform[2].y =oldY
		moving = false
		z_index = 0
	pass
	
func _input(event):
	if event is InputEventMouse:
		mouse_event=event
	pass

func select_target():
	for i in 3:
		if enemys[i].transform[2].x < mouse_event.position.x and enemys[i].transform[2].x + enemys[i].get_rect().size.x > mouse_event.position.x and enemys[i].transform[2].y < mouse_event.position.y and enemys[i].transform[2].y + enemys[i].get_rect().size.y > mouse_event.position.y and battle.card_data.card_target[card_pos] >= 1:
			if enemys[i].alive:
				return i
	if battle.card_data.card_target[card_pos] <= 1 and player.transform[2].x < mouse_event.position.x and player.transform[2].x + player.frames.get_frame("default", 0).get_size().x > mouse_event.position.x and player.transform[2].y < mouse_event.position.y and player.transform[2].y + player.frames.get_frame("default", 0).get_size().x > mouse_event.position.y:
		return 3
	return -1
	

	
func _on_Button_button_down():
	mouse_press = true
	z_index = 2
	if battle.card_data.card_target[card_pos] == 1:
		for i in 3:
			enemys[i].get_node("AnimatedSprite").visible = true
		player.get_node("AnimatedSprite").visible = true
	if battle.card_data.card_target[card_pos] == 0:
		player.get_node("AnimatedSprite").visible = true
	if battle.card_data.card_target[card_pos] == 2:
		for i in 3:
			enemys[i].get_node("AnimatedSprite").visible = true
	pass # Replace with function body.
	
var Card_shadow = preload("res://prefab/Card_shadow.tscn")



func _on_Button_button_up():
	z_index = 1
	for i in 3:
		enemys[i].get_node("AnimatedSprite").visible = false
	player.get_node("AnimatedSprite").visible = false
	card_target = select_target()
	mouse_press = false
	moving = true
	if card_target > -1 and battle.player_turn and !battle.win:
		if player.get_node("buff").buffs[4] > 0 and card_data.index_card_type[card_data.card_index[card_pos]]==2:
			return
		var card_shadow = Card_shadow.instance()
		if battle.card_data.card_type[card_pos] == 0 and player.get_node("buff").buffs[2] > 0: #擴散攻擊
			for i in 3:
				if enemys[i].alive:
					battle.attack(i, card_pos)
			if card_target == 3:
				battle.attack(card_target, card_pos)
			player.get_node("buff").buff_add(2, -1)
		else:
			battle.attack(card_target, card_pos)
		card_shadow.get_node("RichTextLabel").bbcode_text = $RichTextLabel.bbcode_text
		card_shadow.transform = $".".transform
		card_shadow.useX = battle.get_node("Used_deck").transform[2].x
		card_shadow.useY = battle.get_node("Used_deck").transform[2].y
		battle.add_child(card_shadow)
		battle.get_node("Clock").add_time(battle.card_data.card_cost[card_pos])
		transform[2].x = battle.get_node("Deck").transform[2].x
		transform[2].y = battle.get_node("Deck").transform[2].y
		if battle.card_data.consume[card_pos]:
			card_shadow.consume = battle.card_data.consume[card_pos]
		else:
			battle.get_node("Used_deck").use_card(battle.card_data.card_index[card_pos])
		if battle.card_data.card_type[card_pos] == 0: #使用攻擊卡後清除的Buff
			player.get_node("buff").buff_reset(0)
			player.get_node("buff").buff_reset(1)
		battle.card_data.new_index(battle.get_node("Deck").draw_card(), card_pos)
	if !battle.player_turn: #not player turn use card
		pass
	pass # Replace with function body.

extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var max_hp = 100
var hp = max_hp
var shield = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var hp_lose
var hp_rate

func restart():
	max_hp = 100
	hp = max_hp
	shield = 0
	get_node("buff").restart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hp < 0:
		hp = 0
	hp_lose = max_hp - hp
	hp_rate = float(hp) / (float(max_hp) + float(shield))
	if hp == 0:
		if get_node("buff").buffs[3] > 0:
			hp = 10
			get_node("buff").buff_add(3, -1)
			
	$HP/Sprite.scale.x = hp_rate
	$HP/Sprite3.scale.x = (float(hp) + float(shield) )/ (float(max_hp) + float(shield))
	if hp_rate <= 0.2 and $HP/Sprite.texture != load("res://Image/HP_bar4.png"):
		$HP/Sprite.texture = load("res://Image/HP_bar4.png")
	elif hp_rate > 0.2 and $HP/Sprite.texture != load("res://Image/HP_bar2.png"):
		$HP/Sprite.texture = load("res://Image/HP_bar2.png")
	if !get_parent().pause:
		if $HP/Sprite2.scale.x > hp_rate:
			$HP/Sprite2.scale.x -= ($HP/Sprite2.scale.x-hp_rate)*delta*2
		if abs($HP/Sprite2.scale.x - hp_rate) < 0.001 and abs($HP/Sprite2.scale.x - hp_rate) > 0.0001:
			$HP/Sprite2.scale.x = hp_rate
		if shield == 0:
			$HP/Label.bbcode_text = "[right]" + String(hp) + "/" + String(max_hp) + "[/right]"
		else:
			$HP/Label.bbcode_text = "[right]" + String(hp) + "+[color=#0000E3]" + String(shield) + "[/color]/" + String(max_hp) + "[/right]"
	pass

extends Area2D

const VEL = 250

const LENGTH = 5
const MIN_POS_Y = -LENGTH

var move = Vector2(0, -1)

func _ready():
	add_to_group("player_projectile")
	set_process(true)

func _process(delta):
	translate(move * VEL * delta)
	
	if get_global_pos().y < MIN_POS_Y:
		queue_free()
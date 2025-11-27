extends Area2D

const VEL = 120

const SCREEN_H = 600
const LENGTH = 7
const MAX_POS_Y = SCREEN_H + LENGTH

var move = Vector2(0,1)

func _ready():
	set_process(true)

func _process(delta):
	translate(move * VEL * delta)
	
	if get_global_pos().y > MAX_POS_Y:
		destroy(self)

func destroy(caller_node):
	queue_free()


func _on_enemy_projectile_area_enter( area ):
	if area.has_method("destroy"):
		area.destroy(self)
	destroy(self)

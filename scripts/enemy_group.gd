extends Node2D

const PRE_ENEMY_PROJECTILE = preload("res://scenes/enemy_projectile.tscn")

const MIN_SHOT_WAIT_TIME = 0.6
const MAX_SHOT_WAIT_TIME = 1.8

const VEL_X = 6
const VEL_Y = 8
const MIN_ENEMY_POS_X = 20
const MAX_ENEMY_POS_X = 160

var move = 1

func _ready():
	get_node("timer_shot").start()
	get_node("timer_move").start()

func shoot():
	var num_enemies = get_node("enemies").get_child_count()
	var enemy = get_node("enemies").get_child(randi() % num_enemies)
	
	var projectile = PRE_ENEMY_PROJECTILE.instance()
	get_parent().add_child(projectile)
	projectile.set_global_pos(enemy.get_global_pos())

func _on_timer_timeout():
	get_node("timer_shot").set_wait_time(rand_range(MIN_SHOT_WAIT_TIME, MAX_SHOT_WAIT_TIME))
	shoot()

func _on_timer_move_timeout():
	var border = false
	
	for enemy in get_node("enemies").get_children():
		if enemy.get_global_pos().x > MAX_ENEMY_POS_X and move > 0:
			move = -1
			border = true
		elif enemy.get_global_pos().x < MIN_ENEMY_POS_X and move < 0:
			move = 1
			border = true
	
	if border:
		translate(Vector2(0, 1) * VEL_Y)
	else:
		translate(Vector2(move, 0) * VEL_X)

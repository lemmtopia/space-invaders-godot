extends Node2D

const PRE_ENEMY_PROJECTILE = preload("res://scenes/enemy_projectile.tscn")
const PRE_ENEMY_EXPLOSION = preload("res://scenes/enemy_explosion.tscn")
const PRE_ENEMY_SHIP = preload("res://scenes/enemy_ship.tscn")

const MIN_SHOT_WAIT_TIME = 0.6
const MAX_SHOT_WAIT_TIME = 1.8

const MIN_MOVE_WAIT_TIME = 0.2
const MOVE_WAIT_TIME_DECR = 0.01

const VEL_X = 6
const VEL_Y = 8
const MIN_ENEMY_POS_X = 20
const MAX_ENEMY_POS_X = 160

var move = 1
var num_enemies_start = 0

signal enemy_destroyed(enemy)

func _ready():
	start_all()
	
	for enemy in get_node("enemies").get_children():
		enemy.connect("destroyed", self, "on_enemy_destroyed")
	
	num_enemies_start = get_node("enemies").get_child_count()

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
	var num_enemies = get_node("enemies").get_child_count()
	var border = false
	
	get_node("timer_move").set_wait_time(get_node("timer_move").get_wait_time() - MOVE_WAIT_TIME_DECR)
	
	if get_node("timer_move").get_wait_time() <= MIN_MOVE_WAIT_TIME:
		get_node("timer_move").set_wait_time(MIN_MOVE_WAIT_TIME)
	
	for enemy in get_node("enemies").get_children():
		if enemy.get_global_pos().x > MAX_ENEMY_POS_X and move > 0:
			move = -1
			border = true
		elif enemy.get_global_pos().x < MIN_ENEMY_POS_X and move < 0:
			move = 1
			border = true
		
		enemy.next_frame()
	
	if border:
		translate(Vector2(0, 1) * VEL_Y)
	else:
		translate(Vector2(move, 0) * VEL_X)

func on_enemy_destroyed(enemy):
	emit_signal("enemy_destroyed", enemy)
	
	var explosion = PRE_ENEMY_EXPLOSION.instance()
	get_parent().add_child(explosion)
	explosion.set_global_pos(enemy.get_global_pos())


func _on_timer_enemy_ship_timeout():
	get_node("timer_enemy_ship").set_wait_time(rand_range(4, 8))
	get_node("timer_enemy_ship").start()
	
	var enemy_ship = PRE_ENEMY_SHIP.instance()
	enemy_ship.connect("destroyed", self, "on_enemy_destroyed")
	get_parent().add_child(enemy_ship)

func start_all():
	get_node("timer_shot").start()
	get_node("timer_move").start()
	get_node("timer_enemy_ship").start()

func stop_all():
	get_node("timer_shot").stop()
	get_node("timer_move").stop()
	get_node("timer_enemy_ship").stop()
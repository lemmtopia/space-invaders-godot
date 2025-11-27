extends Node2D

const PRE_ENEMY_PROJECTILE = preload("res://scenes/enemy_projectile.tscn")

const MIN_SHOT_WAIT_TIME = 0.6
const MAX_SHOT_WAIT_TIME = 1.8

func _ready():
	get_node("timer_shot").start()

func shoot():
	var num_enemies = get_node("enemies").get_child_count()
	var enemy = get_node("enemies").get_child(randi() % num_enemies)
	
	var projectile = PRE_ENEMY_PROJECTILE.instance()
	get_parent().add_child(projectile)
	projectile.set_global_pos(enemy.get_global_pos())

func _on_timer_timeout():
	get_node("timer_shot").set_wait_time(rand_range(MIN_SHOT_WAIT_TIME, MAX_SHOT_WAIT_TIME))
	shoot()